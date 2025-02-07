import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/feature/chat/data/repo/chat_repo_impl.dart';
import 'package:loan_management/feature/chat/presentation/view/widget/chat_bubble.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_cubit.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagesListView extends StatelessWidget {
  final List usersId;
  const MessagesListView({super.key, required this.usersId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(ChatRepoImpl())
        ..fetchMessages(
          user1Id: usersId[0],
          user2Id: usersId[1],
        ),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MessageLoaded) {
            return ListView.builder(
                reverse: true,
              
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: state.messages[index].senderId ==
                            Supabase.instance.client.auth.currentUser?.id
                        ? ChatBubble(massage: state.messages[index])
                        : ChatBubbleFriend(massage: state.messages[index]),
                  );
                });
          } else if (state is MessageError) {
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
