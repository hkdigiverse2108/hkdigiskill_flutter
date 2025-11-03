import 'package:flutter/material.dart';
import '../../app/themes/app_colors.dart'; // your colors
import '../../app/themes/app_text_styles.dart'; // your text styles (optional)

class AppTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? initialValue;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final double? height; // <- new argument

  const AppTextField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.enabled = true,
    this.initialValue,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.height, // <- new argument
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label + required star
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: AppColors.textLight,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            children: isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 16,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: height, // <- uses custom height if provided
          child: Align(
            alignment: Alignment.center,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              initialValue: initialValue,
              enabled: enabled,
              maxLength: maxLength,
              validator:
                  validator ??
                  (value) {
                    if (isRequired && (value == null || value.isEmpty)) {
                      return 'This field is required';
                    }
                    return null;
                  },
              style: TextStyle(
                color: AppColors.textLight,
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
              minLines: minLines,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: AppColors.caption,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
                filled: true,
                fillColor: AppColors.backgroundLight,
                contentPadding: height != null
                    ? EdgeInsets.symmetric(horizontal: 16, vertical: 0)
                    : EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.caption.withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.error),
                ),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
