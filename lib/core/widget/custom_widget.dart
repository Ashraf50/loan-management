import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant/app_styles.dart';

class CustomWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/img/money.svg",
                height: 30,
              ),
              const SizedBox(width: 10),
              Text(
                "$title: ",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: AppStyles.textStyle18White,
          ),
        ],
      ),
    );
  }
}
