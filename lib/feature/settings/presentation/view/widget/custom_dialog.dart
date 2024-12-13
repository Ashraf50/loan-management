import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import '../../../../../generated/l10n.dart';

customDialog(BuildContext context, String newEmail) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${S.of(context).verify_message} $newEmail",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20,
            ),
            const SizedBox(height: 30),
            SvgPicture.asset("assets/img/verify.svg"),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
