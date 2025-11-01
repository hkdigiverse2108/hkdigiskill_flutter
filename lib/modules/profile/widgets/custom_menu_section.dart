import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

class CustomMenuSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final List<VoidCallback?> actions;
  final bool expanded;
  final VoidCallback onHeaderTap;

  const CustomMenuSection({
    Key? key,
    required this.title,
    required this.icon,
    required this.items,
    required this.actions,
    required this.expanded,
    required this.onHeaderTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Tappable)
          InkWell(
            onTap: onHeaderTap,
            borderRadius: BorderRadius.circular(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(icon, size: 30, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Divider line
          expanded
              ? Divider(height: 1, indent: 60, color: Colors.grey.shade300)
              : SizedBox.shrink(),
          // Items (visible only if expanded)
          AnimatedCrossFade(
            crossFadeState: expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 200),
            firstChild: Column(
              children: List.generate(items.length, (index) {
                return InkWell(
                  onTap: actions[index],
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 60,
                      right: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            secondChild: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// ---- USAGE in a parent widget ----

class MenuAccordion extends StatefulWidget {
  const MenuAccordion({Key? key}) : super(key: key);

  @override
  State<MenuAccordion> createState() => _MenuAccordionState();
}

class _MenuAccordionState extends State<MenuAccordion> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomMenuSection(
          title: "Learning & Resources",
          icon: Icons.person,
          items: [
            "Instructor",
            "Blogs",
            "Gallery",
            "Testimonials",
            "Frequent Ask Questions",
          ],
          actions: [() {}, () {}, () {}, () {}, () {}],
          expanded: expandedIndex == 0,
          onHeaderTap: () {
            setState(() {
              expandedIndex = expandedIndex == 0 ? null : 0;
            });
          },
        ),
        CustomMenuSection(
          title: "Company & Legal Info",
          icon: Icons.verified_user,
          items: [
            "About Us",
            "Contact Us",
            "Terms & Condition",
            "Privacy Policy",
            "News Letter",
          ],
          actions: [() {}, () {}, () {}, () {}, () {}],
          expanded: expandedIndex == 1,
          onHeaderTap: () {
            setState(() {
              expandedIndex = expandedIndex == 1 ? null : 1;
            });
          },
        ),
        CustomMenuSection(
          title: "Account Settings",
          icon: Icons.settings,
          items: ["Update Profile", "Change Password", "Delete Account"],
          actions: [() {}, () {}, () {}],
          expanded: expandedIndex == 2,
          onHeaderTap: () {
            setState(() {
              expandedIndex = expandedIndex == 2 ? null : 2;
            });
          },
        ),
      ],
    );
  }
}
