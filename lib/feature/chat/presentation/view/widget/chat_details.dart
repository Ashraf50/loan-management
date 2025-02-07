import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/chat/presentation/view/widget/messages_list.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_cubit.dart';
import '../../../../../generated/l10n.dart';

class ChatDetailsView extends StatefulWidget {
  final List usersId;
  const ChatDetailsView({super.key, required this.usersId});

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final TextEditingController _controller = TextEditingController();
  bool _isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isNotEmpty = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "Ashraf Essam"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(child: MessagesListView(usersId: widget.usersId)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: S.of(context).send_mess,
                  suffixIcon: _isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            if (_isNotEmpty) {
                              final chatCubit = context.read<ChatCubit>();
                              chatCubit.sendMessage(
                                receiverId:
                                    "e20d264a-96ff-4971-a250-6e61fb7536d1",
                                message: _controller.text,
                              );
                              _controller.clear();
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
