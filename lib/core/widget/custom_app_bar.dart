import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:provider/provider.dart';
import '../constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: themeProvider.isDarkTheme
          ? AppColors.scaffoldColorDark
          : Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
