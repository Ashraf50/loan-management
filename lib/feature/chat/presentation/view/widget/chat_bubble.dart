import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/date_format.dart';
import 'package:loan_management/feature/chat/data/model/message.dart';

class ChatBubbleFriend extends StatelessWidget {
  final MessageModel massage;
  const ChatBubbleFriend({
    super.key,
    required this.massage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xff006D84),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Text(
              massage.message!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              dateTimeFormat(
                massage.timestamp.toString(),
                'hh:mm a',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageModel massage;
  const ChatBubble({super.key, required this.massage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              ),
            ),
            child: Text(
              massage.message!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              dateTimeFormat(
                massage.timestamp.toString(),
                'hh:mm a',
              ),
            ),
          )
        ],
      ),
    );
  }
}
