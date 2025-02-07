import 'package:flutter/material.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';
import 'chats_list_view.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).chat),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: const [
            SizedBox(height: 20),
            ChatsListView(),
          ],
        ),
      ),
    );
  }
}
