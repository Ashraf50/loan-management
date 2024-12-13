import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/constant/app_theme.dart';

class CheckedAccount extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final void Function() buttonOnTap;
  const CheckedAccount({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.buttonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        title,
        style: AppStyles.textStyle18black,
      ),
      const SizedBox(width: 6),
      InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: buttonOnTap,
        child: Text(
          buttonTitle,
          style: themeProvider.isDarkTheme
              ? AppStyles.textStyle18
              : AppStyles.textStyle18green,
        ),
      )
    ]);
  }
}
