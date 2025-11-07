import 'package:flutter/material.dart';
import '../../app/themes/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Icon data for bottom nav, replace with your real SVGs if needed
    final icons = [
      Icons.grid_view_rounded, // Dashboard
      Icons.menu_book_rounded, // Books/Library
      Icons.school_rounded, // Center (active/floating)
      Icons.account_balance_rounded, // Institute
      Icons.chat_bubble_outline_rounded, // Chat/Message
    ];

    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.caption.withOpacity(0.55);

    Widget buildAnimatedIcon(int idx) {
      final isActive = currentIndex == idx;
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: isActive ? 1.18 : 1.0),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return IconButton(
            iconSize: 24 * scale,
            icon: Icon(
              icons[idx],
              color: Color.lerp(
                inactiveColor,
                activeColor,
                isActive ? 1.0 : 0.0,
              ),
            ),
            onPressed: () => onTap(idx),
          );
        },
      );
    }

    // Floating center icon with animated highlight
    Widget buildFloatingIcon() {
      final isActive = currentIndex == 2;
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: isActive ? 1.12 : 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return Material(
            color: Colors.transparent,
            elevation: 2,
            shape: const CircleBorder(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
              padding: const EdgeInsets.all(6),
              decoration: ShapeDecoration(
                color: isActive
                    ? activeColor.withValues(alpha: 0.18)
                    : activeColor.withValues(alpha: 0.10),
                shape: const CircleBorder(),
                // shadows: isActive
                //     ? [
                //         BoxShadow(
                //           color: activeColor.withOpacity(0.14),
                //           blurRadius: 16,
                //           spreadRadius: 0,
                //           offset: const Offset(0, 4),
                //         ),
                //       ]
                //     : [],
              ),
              child: Transform.scale(
                scale: scale,
                child: IconButton(
                  icon: Icon(
                    icons[2],
                    size: 32,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                  onPressed: () => onTap(2),
                ),
              ),
            ),
          );
        },
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 74,
          margin: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildAnimatedIcon(0),
              buildAnimatedIcon(1),
              const SizedBox(width: 54), // Space for floating icon
              buildAnimatedIcon(3),
              buildAnimatedIcon(4),
            ],
          ),
        ),
        // Animated floating center icon
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(child: buildFloatingIcon()),
        ),
      ],
    );
  }
}
