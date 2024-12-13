import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_theme.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final Color enableColor;
  const CustomTextfield({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    required this.controller,
    this.autovalidateMode,
    this.validator,
    required this.enableColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: validator,
        autovalidateMode: autovalidateMode,
        controller: controller,
        obscureText: obscureText ?? false,
        cursorColor:
            themeProvider.isDarkTheme ? AppColors.white : AppColors.black,
        style: TextStyle(
            color:
                themeProvider.isDarkTheme ? AppColors.white : AppColors.black,
            fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: enableColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeProvider.isDarkTheme
                  ? AppColors.primaryColor
                  : AppColors.primaryColor,
            ),
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
