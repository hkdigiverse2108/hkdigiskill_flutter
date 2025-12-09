import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

class CustomMenuSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final List<VoidCallback?> actions;
  final bool expanded;
  final VoidCallback onHeaderTap;
  final List<int>? iconNotShow;

  const CustomMenuSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.actions,
    required this.expanded,
    required this.onHeaderTap,
    this.iconNotShow,
  });

  @override
  State<CustomMenuSection> createState() => _CustomMenuSectionState();
}

class _CustomMenuSectionState extends State<CustomMenuSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _staggeredMs = 60; // ms delay per item

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        milliseconds: widget.items.length * _staggeredMs + 200,
      ),
      vsync: this,
    );
    if (widget.expanded) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomMenuSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != widget.expanded) {
      if (widget.expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          InkWell(
            onTap: widget.onHeaderTap,
            borderRadius: BorderRadius.circular(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(widget.icon, size: 30, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: widget.expanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          widget.expanded
              ? Divider(height: 1, indent: 60, color: Colors.grey.shade300)
              : const SizedBox.shrink(),
          AnimatedCrossFade(
            crossFadeState: widget.expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 200),
            firstChild: Column(
              children: List.generate(widget.items.length, (index) {
                final start =
                    index * _staggeredMs / _controller.duration!.inMilliseconds;
                final end = start + 0.5;
                final animation = CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    start,
                    end.clamp(0.0, 1.0),
                    curve: Curves.easeOut,
                  ),
                );
                return AnimatedMenuItem(
                  text: widget.items[index],
                  onTap: widget.actions[index],
                  animation: animation,
                  showIcon: widget.iconNotShow?.contains(index) ?? false,
                );
              }),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class AnimatedMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Animation<double> animation;
  final bool? showIcon;

  const AnimatedMenuItem({
    required this.text,
    required this.onTap,
    required this.animation,
    this.showIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0), // slide from right
        end: Offset.zero,
      ).animate(animation),
      child: InkWell(
        onTap: onTap,
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
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              if (showIcon != true)
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black38,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---- USAGE in a parent widget ----

// class MenuAccordion extends StatefulWidget {
//   const MenuAccordion({super.key});
//
//   @override
//   State<MenuAccordion> createState() => _MenuAccordionState();
// }
//
// class _MenuAccordionState extends State<MenuAccordion> {
//   int? expandedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         CustomMenuSection(
//           title: "Learning & Resources",
//           icon: Icons.person,
//           items: [
//             "Instructor",
//             "Blogs",
//             "Gallery",
//             "Testimonials",
//             "Frequent Ask Questions",
//           ],
//           actions: [() {}, () {}, () {}, () {}, () {}],
//           expanded: expandedIndex == 0,
//           onHeaderTap: () {
//             setState(() {
//               expandedIndex = expandedIndex == 0 ? null : 0;
//             });
//           },
//         ),
//         CustomMenuSection(
//           title: "Company & Legal Info",
//           icon: Icons.verified_user,
//           items: [
//             "About Us",
//             "Contact Us",
//             "Terms & Condition",
//             "Privacy Policy",
//             "News Letter",
//           ],
//           actions: [() {}, () {}, () {}, () {}, () {}],
//           expanded: expandedIndex == 1,
//           onHeaderTap: () {
//             setState(() {
//               expandedIndex = expandedIndex == 1 ? null : 1;
//             });
//           },
//         ),
//         CustomMenuSection(
//           title: "Account Settings",
//           icon: Icons.settings,
//           items: ["Update Profile", "Change Password", "Delete Account"],
//           actions: [() {}, () {}, () {}],
//           expanded: expandedIndex == 2,
//           onHeaderTap: () {
//             setState(() {
//               expandedIndex = expandedIndex == 2 ? null : 2;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
