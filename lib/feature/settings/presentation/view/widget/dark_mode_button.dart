import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../../../generated/l10n.dart';

class DarkModeButton extends StatefulWidget {
  const DarkModeButton({super.key});

  @override
  State<DarkModeButton> createState() => _DarkModeButtonState();
}

class _DarkModeButtonState extends State<DarkModeButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeProvider.isDarkTheme
              ? AppColors.widgetColorDark
              : AppColors.whiteGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/img/dark_mode.svg',
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    themeProvider.isDarkTheme
                        ? AppColors.white
                        : AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  S.of(context).dark_mode,
                  style: AppStyles.textStyle18black,
                ),
              ],
            ),
            Switch(
              value: themeProvider.isDarkTheme,
              onChanged: (val) {
                themeProvider.setThemeData = val;
              },
              activeColor: AppColors.primaryColor,
              trackOutlineColor: WidgetStateProperty.all(
                themeProvider.isDarkTheme
                    ? AppColors.widgetColorDark
                    : AppColors.whiteGrey,
              ),
              inactiveThumbColor: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
