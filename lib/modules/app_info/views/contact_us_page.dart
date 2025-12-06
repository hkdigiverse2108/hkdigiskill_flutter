import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/app_info/controllers/contact_us_controller.dart';
import 'package:hkdigiskill/shared/widgets/widget_animation_wrapper.dart';

class ContactUsPage extends GetView<ContactUsController> {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: WidgetAnimationWrapper(
          index: 0,
          animationTypes: [AnimationType.fade],
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              _contactTile(
                title: "Email",
                subtitle: "Send us an email",
                icon: Icons.email_outlined,
                onTap: () => controller.openEmail(),
              ),
              const SizedBox(height: 14),

              _contactTile(
                title: "WhatsApp",
                subtitle: "Chat with us",
                icon: Icons.chat_bubble_outline,
                onTap: () => controller.openWhatsApp(),
              ),
              const SizedBox(height: 14),

              _contactTile(
                title: "Support",
                subtitle: "Visit support page",
                icon: Icons.support_agent_outlined,
                onTap: () => controller.openSupport(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
