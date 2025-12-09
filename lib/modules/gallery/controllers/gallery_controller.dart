import 'dart:developer';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/gallery/gallery_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class GalleryController extends GetxController {
  final List<GalleryModel> galleries = <GalleryModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getGalleries();
  }

  void getGalleries() async {
    try {
      isLoading.value = true;
      var response = await ApiService.to.get(ApiConstants.galleryEndpoint);

      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['gallery_data'] ?? [];

        galleries.assignAll(
          data.map((item) => GalleryModel.fromJson(item)).toList(),
        );
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Place Try Again Later");
    } finally {
      isLoading.value = false;
    }
  }
}
