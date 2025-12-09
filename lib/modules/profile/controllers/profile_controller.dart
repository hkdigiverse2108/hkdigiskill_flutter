import 'dart:convert';
import 'dart:developer';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/user/user_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  // -1 means none expanded, 0=Learning, 1=Company, 2=Account
  RxInt expandedSection = (-1).obs;
  final storage = StorageService();
  RxBool isImageChanged = false.obs;
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;

  final ImagePicker picker = ImagePicker();
  final Rx<File?> pickedImage = Rx<File?>(null);

  @override
  void onInit() {
    Future.microtask(() => _initLogo());
    super.onInit();
  }

  Future<void> _initLogo() async {
    final context = Get.context;
    if (context != null) {
      // ✅ Preload images to remove loading lag
      await Future.wait([precacheImage(AssetImage(AppImages.logo), context)]);
    }
  }

  void toggleSection(int index) {
    if (expandedSection.value == index) {
      expandedSection.value = -1; // Collapse if already open
    } else {
      expandedSection.value = index; // Open
    }
  }

  final nameCtrl = TextEditingController(
    text: Globals.userData.value?.fullName ?? "",
  );
  final phoneCtrl = TextEditingController(
    text: Globals.userData.value?.phoneNumber ?? "",
  );
  final designationCtrl = TextEditingController(
    text: Globals.userData.value?.designation ?? "",
  );
  final Rx<String?> photoUrl =
      Globals.userData.value?.profilePhoto.obs ?? "".obs;

  Future<void> pickImage({bool camera = false}) async {
    final XFile? image = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      pickedImage.value = File(image.path);
      isImageChanged.value = true;

      // Replace network photo with picked file
      photoUrl.value = null;
    }
  }

  void validateFields() {
    if (nameCtrl.text.isEmpty) {
      AppSnackbar.error("Name is required");
    } else if (phoneCtrl.text.isEmpty) {
      AppSnackbar.error("Phone number is required");
    } else if (designationCtrl.text.isEmpty) {
      AppSnackbar.error("Designation is required");
    } else {
      updateProfile();
    }
  }

  Future<File> saveImageToLocalDir(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName = p.basename(file.path);
    final newFile = File('$path/$fileName');
    return await file.copy(newFile.path);
  }

  void updateProfile() async {
    try {
      isLoading.value = true;

      if (isImageChanged.value) {
        await storeProfileImage();
      }

      final res = await ApiService.to.post(
        ApiConstants.updateProfileEndpoint,
        body: {
          'userId': Globals.userData.value!.id,
          'fullName': nameCtrl.text,
          'phoneNumber': phoneCtrl.text,
          'designation': designationCtrl.text,
          'profilePhoto': photoUrl.value,
        },
      );

      log(res.toString());
      if (res['status'] == 200) {
        await getUserProfile();
        Get.snackbar('Success', res['message']);
      } else {
        Get.snackbar('Error', res['message']);
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> storeProfileImage() async {
    try {
      if (pickedImage.value == null) {
        log('No image selected');
        isImageChanged.value = false;
        return;
      }

      // Optionally delete old image if exists
      if (photoUrl.value != null && photoUrl.value!.isNotEmpty) {
        try {
          await ApiService.to.delete(
            ApiConstants.uploadEndpoint,
            body: {'imageUrl': photoUrl.value},
          );
        } catch (e) {
          log('Error deleting old image: $e');
          // Continue with upload even if delete fails
        }
      }

      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.uploadEndpoint}'),
      );

      // Add headers
      final token = StorageService().token;
      if (token.isNotEmpty) {
        request.headers['authorization'] = token;
      }
      request.headers['Accept'] = 'application/json';

      // Add the image file - EXACTLY matching your working postDropzoneFiles
      final imageBytes = await pickedImage.value!.readAsBytes();
      final filename = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final mimeType = _getMimeType(filename); // Add this helper below

      final multipartFile = http.MultipartFile.fromBytes(
        'images', // ✅ Matches server expectation (not images[0])
        imageBytes,
        filename: filename,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
      request.files.add(multipartFile);

      // Add the category field
      request.fields['category'] = 'user';

      log('Uploading ${multipartFile.filename} as images[]');

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      log('Status: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
          "Server error ${response.statusCode}: ${response.body}",
        );
      }

      final data = json.decode(response.body);

      if (data['status'] == 200) {
        final images = data["data"]["images"];
        if (images != null && images.isNotEmpty) {
          photoUrl.value = images.first;
          isImageChanged.value = false;
          log('Profile image uploaded: ${photoUrl.value}');
        } else {
          throw Exception("No image URL returned in response");
        }
      } else {
        throw Exception("Upload failed: ${data['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      log('Error in storeProfileImage: $e');
      rethrow;
    }
  }

  /// Helper method - copy from your working code
  String? _getMimeType(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      default:
        return 'image/jpeg'; // Default for profile images
    }
  }

  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;
      final res = await ApiService.to.get(
        ApiConstants.getUserEndpoint + Globals.userData.value!.id,
      );

      if (res['status'] == 200) {
        storage.userData = res['data'];
        Globals.userData.value = UserModel.fromJson(res['data']);
        Get.back();
      }
      log(res.toString());
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showSignOutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sign Out',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // main color for confirm
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              storage.clearUserData();
              Get.offAllNamed(Routes.login);
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      barrierDismissible: false, // prevents accidental popup dismiss
    );
  }

  void onDeleteAccountTap(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final reasonController = TextEditingController();
    final rateUsController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                label: 'Name',
                controller: nameController,
                isRequired: true,
                height: 50,
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                isRequired: true,
                height: 50,
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Password',
                controller: passwordController,
                obscureText: true,
                isRequired: true,
                height: 50,
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Rate Us (1 - 10)',
                controller: rateUsController,
                keyboardType: TextInputType.number,
                obscureText: true,
                isRequired: true,
                height: 50,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Reason for deleting account',
                controller: reasonController,
                minLines: 2,
                maxLines: 4,
                isRequired: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final name = nameController.text.trim();
              final email = emailController.text.trim();
              final password = passwordController.text;
              final reason = reasonController.text.trim();
              final rate = rateUsController.text.trim();

              try {
                isDeleting.value = true;
                final res = await ApiService.to.post(
                  ApiConstants.deleteAccountEndpoint,
                  body: {
                    'name': name,
                    'email': email,
                    'password': password,
                    'reason': reason,
                    'rate': int.parse(rate),
                  },
                );

                if (res['status'] == 200) {
                  storage.clearUserData();
                  Get.offAllNamed(Routes.login);
                  AppSnackbar.success(res['message']);
                } else {
                  Get.back();
                  AppSnackbar.error("Can't delete account");
                }
              } catch (e) {
                log(e.toString());
              } finally {
                isDeleting.value = false;
              }

              // Dismiss dialog after action
            },
            child: Obx(
              () => isDeleting.value
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void newsLetter() async {
    try {
      final res = await ApiService.to.post(
        ApiConstants.newsLetterEndpoint,
        body: {'email': Globals.userData.value!.email},
      );

      if (res['status'] == 200) {
        AppSnackbar.success(res['message']);
      } else {
        AppSnackbar.info(res['message']);
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.info("Your Email is already Added");
    }
  }
}
