import 'package:flutter/material.dart';
import '../../../../../../core/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primaryColor,
          border: Border.all(
            color: AppColors.primaryColor,
          ),
        ),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
