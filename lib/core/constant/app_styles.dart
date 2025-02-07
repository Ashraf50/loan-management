import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_colors.dart';

class AppStyles {
  static const TextStyle textStyle18black = TextStyle(
    fontSize: 18,
  );
  static const TextStyle textStyle18White = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
  static const TextStyle textStyle18gray = TextStyle(
    fontSize: 18,
    color: AppColors.grey,
  );
  static const TextStyle textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle textStyle20notBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textStyle20notBoldWhite = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle textStyle24black = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textStyle18green = TextStyle(
    fontSize: 18,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primaryColor,
    color: AppColors.primaryColor,
  );
  static const TextStyle textStyle18 = TextStyle(
    fontSize: 18,
    color: Color(0xffA8D5BA),
    decoration: TextDecoration.underline,
    decorationColor: Color(0xffA8D5BA),
  );
}
