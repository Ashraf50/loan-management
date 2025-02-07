import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/date_format.dart';
import '../../../data/model/chat_model.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chat;
  const ChatItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 25,
              child: Text(
                "AE",
                style: AppStyles.textStyle18White,
              ),
            ),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Ashraf Essam", style: AppStyles.textStyle20),
              Text(
                chat.lastMessage!,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ]),
          ],
        ),
        Text(
          dateTimeFormat(chat.lastUpdated!.toString(), 'hh:mm a'),
          style: AppStyles.textStyle18black,
        )
      ],
    );
  }
}
