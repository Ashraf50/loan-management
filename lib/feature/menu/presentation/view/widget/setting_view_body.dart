import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_string.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/menu/presentation/view/widget/custom_list_tile.dart';
import 'package:loan_management/feature/menu/presentation/view/widget/dark_mode_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../generated/l10n.dart';

class SettingViewBody extends StatelessWidget {
  const SettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).setting),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const DarkModeButton(),
            const SizedBox(height: 8),
            CustomListTile(
              image: "assets/img/language.svg",
              onTap: () {
                context.push('/language_view');
              },
              title: S.of(context).language,
            ),
            Divider(
              color: themeProvider.isDarkTheme
                  ? AppColors.widgetColorDark
                  : AppColors.whiteGrey,
              thickness: 4,
            ),
            Text(
              S.of(context).about_us,
              style: AppStyles.textStyle20,
            ),
            const SizedBox(height: 8),
            CustomListTile(
              image: "assets/img/about.svg",
              onTap: () {
                context.push('/about_view');
              },
              title: S.of(context).about_us,
            ),
            Text(
              S.of(context).contact_us,
              style: AppStyles.textStyle20,
            ),
            const SizedBox(height: 8),
            CustomListTile(
              image: "assets/img/facebook.svg",
              onTap: () {
                openLink(AppStrings.facebookLink);
              },
              title: S.of(context).facebook,
            ),
            CustomListTile(
              image: "assets/img/whatsapp.svg",
              onTap: () {
                openLink(AppStrings.whatsappLink);
              },
              title: S.of(context).whatsapp,
            )
          ],
        ),
      ),
    );
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
