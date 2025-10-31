import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile image (use your network/local asset)
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://randomuser.me/api/portraits/women/32.jpg', // Replace with actual user image URL
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
                  const Text(
                    'Namaste, Het',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: 'Poppins',
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
            // Get.toNamed(Routes.notification);
          },
          child: SvgPicture.asset(AppImages.notification),
        ),
      ],
    );
  }
}
