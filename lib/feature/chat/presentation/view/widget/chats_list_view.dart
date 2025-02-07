import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/feature/chat/data/repo/chat_repo_impl.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_cubit.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_state.dart';
import 'chat_item.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(ChatRepoImpl())..fetchChats(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatLoaded) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(
                        '/chat_details',
                        extra: state.chats[index].users,
                      );
                    },
                    child: ChatItem(chat: state.chats[index]),
                  );
                });
          } else if (state is ChatError) {
            return Center(
              child: Text(state.errMessage),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
