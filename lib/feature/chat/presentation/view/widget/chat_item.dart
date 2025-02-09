import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/date_format.dart';
import 'package:loan_management/core/helper/chat_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/model/chat_model.dart';

class ChatItem extends StatefulWidget {
  final ChatModel chat;
  const ChatItem({super.key, required this.chat});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final currentUserId = Supabase.instance.client.auth.currentUser!.id;
  String chatTitle = "Loading...";
  @override
  void initState() {
    super.initState();
    _fetchChatTitle();
  }

  Future<void> _fetchChatTitle() async {
    final otherUserId =
        widget.chat.users!.firstWhere((id) => id != currentUserId);
    final title = await ChatHelper.fetchChatTitle(currentUserId, otherUserId);
    setState(() {
      chatTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 25,
                child: Text(
                  ChatHelper.getInitials(chatTitle),
                  style: AppStyles.textStyle18White,
                ),
              ),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(chatTitle, style: AppStyles.textStyle20),
                Text(
                  widget.chat.lastMessage!,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ]),
            ],
          ),
          Text(
            dateTimeFormat(widget.chat.lastUpdated!.toString(), 'hh:mm a'),
            style: AppStyles.textStyle18black,
          )
        ],
      ),
    );
  }
}
