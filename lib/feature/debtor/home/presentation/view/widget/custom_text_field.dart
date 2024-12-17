import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:provider/provider.dart';

class CustomTextfield extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  const CustomTextfield({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.readOnly,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        validator: validator,
        autovalidateMode: autovalidateMode,
        readOnly: readOnly ?? false,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor:
            themeProvider.isDarkTheme ? AppColors.white : AppColors.black,
        style: AppStyles.textStyle18black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: themeProvider.isDarkTheme
                    ? AppColors.white
                    : AppColors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
