import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

class HeaderBadge extends StatelessWidget {
  final String label;
  final IconData? icon;

  const HeaderBadge({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: icon == null
          ? EdgeInsets.symmetric(horizontal: 20, vertical: 7)
          : EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.textDark),
            SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: AppColors.textDark,
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
