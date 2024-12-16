import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;
  final Widget? icon;
  const ProfileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color:
              theme.isDarkTheme ? AppColors.scaffoldColorDark : AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        title,
                        style: AppStyles.textStyle20,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SelectableText(
                        subTitle,
                        style: AppStyles.textStyle20notBold,
                      ),
                    ),
                  ],
                ),
              ),
              if (icon != null)
                InkWell(
                  onTap: onTap,
                  child: icon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
