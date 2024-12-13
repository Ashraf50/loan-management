import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../generated/l10n.dart';

class FinishResetPassView extends StatelessWidget {
  const FinishResetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 600 ? 16 : screenWidth * .15),
        child: ListView(
          children: [
            SizedBox(
              width: screenWidth * 0.6,
              height: screenHeight * 0.4,
              child: Lottie.asset(
                'assets/img/check.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              S.of(context).new_pass_message1,
              style: AppStyles.textStyle18black,
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              width: double.infinity,
              title: S.of(context).login,
              onTap: () {
                context.go('/sign_in');
              },
              buttonColor: AppColors.primaryColor,
              textColor: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
