import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile image (use your network/local asset)
        Obx(
          () => GestureDetector(
            onTap: () {
              if (networkController.isConnected.value) {
                Get.toNamed(Routes.profile);
              }
            },
            child: Hero(
              tag: 'profile-avatar',
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  Globals.fixLocalhostUrl(
                    Globals.userData.value?.profilePhoto ??
                        "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Greeting text and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      (Globals.userData.value?.fullName.isNotEmpty ?? false)
                          ? (Globals.userData.value?.fullName
                                            .split(' ')[0]
                                            .length ??
                                        0) >
                                    7
                                ? 'Namaste, ${Globals.userData.value?.fullName.substring(0, 7)}...'
                                : 'Namaste, ${Globals.userData.value?.fullName.split(' ')[0]}'
                          : "User",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Text('🙏', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Your AI learning journey begins today.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Notification icon
        InkWell(
          onTap: () {
            Get.toNamed(Routes.notification);
          },
          child: SvgPicture.asset(AppImages.notification),
        ),
      ],
    );
  }
}
