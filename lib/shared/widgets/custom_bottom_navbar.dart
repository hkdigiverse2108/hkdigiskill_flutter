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

    // Colors
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.caption.withOpacity(0.55);

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
              // Left icons
              IconButton(
                icon: Icon(
                  icons[0],
                  color: currentIndex == 0 ? activeColor : inactiveColor,
                ),
                onPressed: () => onTap(0),
              ),
              IconButton(
                icon: Icon(
                  icons[1],
                  color: currentIndex == 1 ? activeColor : inactiveColor,
                ),
                onPressed: () => onTap(1),
              ),
              SizedBox(width: 54), // Space for the floating icon
              IconButton(
                icon: Icon(
                  icons[3],
                  color: currentIndex == 3 ? activeColor : inactiveColor,
                ),
                onPressed: () => onTap(3),
              ),
              IconButton(
                icon: Icon(
                  icons[4],
                  color: currentIndex == 4 ? activeColor : inactiveColor,
                ),
                onPressed: () => onTap(4),
              ),
            ],
          ),
        ),
        // Floating center icon
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: activeColor.withOpacity(0.10),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(icons[2], size: 32, color: activeColor),
                  onPressed: () => onTap(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
