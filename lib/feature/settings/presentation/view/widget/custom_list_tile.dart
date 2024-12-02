import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/constant/app_theme.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String image;
  final void Function() onTap;
  const CustomListTile({
    super.key,
    required this.image,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: themeProvider.isDarkTheme
                  ? AppColors.widgetColorDark
                  : AppColors.whiteGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        image,
                        height: 25,
                        colorFilter: ColorFilter.mode(
                          themeProvider.isDarkTheme
                              ? AppColors.white
                              : AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          title,
                          style: AppStyles.textStyle18black,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
