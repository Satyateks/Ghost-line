import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';

class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fillColor =
        isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.72);

    final borderColor =
        isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.95);

    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final hintColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.authField),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onTap: onTap,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          cursorColor: AppColors.primaryBlue,
          style: AppTextStyles.authInput(textColor),
          decoration: InputDecoration(
            counterText: "",
            labelText: label,
            hintText: hint,
            hintStyle: AppTextStyles.authHint(hintColor),
            labelStyle: AppTextStyles.authHint(hintColor),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            focusedBorder: _border(AppColors.primaryBlue.withOpacity(0.75)),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.authField),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}