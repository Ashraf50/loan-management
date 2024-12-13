import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).profile),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomButton(
          title: S.of(context).logout,
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            context.go('/signInView');
          },
          width: double.infinity,
        ),
      ),
    );
  }
}
