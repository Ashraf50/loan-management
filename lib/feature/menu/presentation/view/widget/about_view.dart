import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).about_us),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            SelectableText(
              S.of(context).about_us_body,
              style: AppStyles.textStyle20,
            )
          ],
        ),
      ),
    );
  }
}
