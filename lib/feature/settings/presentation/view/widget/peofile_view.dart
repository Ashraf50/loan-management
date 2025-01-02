import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).profile),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: S.of(context).personal_info,
              onTap: () async {
                context.push('/personalInfo');
              },
              width: double.infinity,
            ),
            CustomButton(
              title: S.of(context).delete_acc,
              onTap: () async {
                openLink("https://deleteeltzamatiaccount.netlify.app");
              },
              width: double.infinity,
            ),
            CustomButton(
              title: S.of(context).logout,
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
                final pref = await SharedPreferences.getInstance();
                pref.remove("userRole");
                context.go('/signInView');
              },
              width: double.infinity,
            ),
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
