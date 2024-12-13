import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_theme.dart';

class RoleButton extends StatelessWidget {
  final String selectedRole;
  final void Function() onTap;
  final String title;
  const RoleButton({
    super.key,
    required this.selectedRole,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        decoration: BoxDecoration(
          color: selectedRole == title
              ? AppColors.primaryColor
              : themeProvider.isDarkTheme
                  ? AppColors.scaffoldColorDark
                  : AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: selectedRole == title
                ? AppStyles.textStyle18White
                : AppStyles.textStyle18black,
          ),
        ),
      ),
    );
  }
}
