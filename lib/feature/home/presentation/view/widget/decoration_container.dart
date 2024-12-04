import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_theme.dart';

class DecorationContainer extends StatelessWidget {
  final Widget widget;
  const DecorationContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    final themeProvide = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: themeProvide.isDarkTheme
            ? AppColors.scaffoldColorDark
            : AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: widget,
      ),
    );
  }
}
