import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/custom_toast.dart';
import 'package:loan_management/feature/chat/presentation/view/widget/chat_bubble.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_cubit.dart';
import 'package:loan_management/feature/chat/presentation/view_model/cubit/chats_state.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagesListView extends StatefulWidget {
  final List usersId;
  const MessagesListView({super.key, required this.usersId});

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  late ScrollController _scrollController;
  late ChatCubit chatCubit;
  @override
  void initState() {
    super.initState();
    chatCubit = context.read<ChatCubit>();
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      chatCubit.loadMoreMessages(widget.usersId[0], widget.usersId[1]);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.95);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is MessageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MessageLoaded) {
          return ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                final isMe = message.senderId ==
                    Supabase.instance.client.auth.currentUser?.id;
                return InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onLongPress: () {
                    _showMessageOptions(context, message.id!, message.message!);
                  },
                  child: isMe
                      ? ChatBubble(massage: message)
                      : ChatBubbleFriend(massage: message),
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
    );
  }

  void _showMessageOptions(
      BuildContext context, String messageId, String text) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.copy),
                title: Text(S.of(context).copy_mess),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: text));
                  context.pop(context);
                  CustomToast.show(message: S.of(context).mess_copied);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(S.of(context).delete_mess),
                onTap: () {
                  context.read<ChatCubit>().removeMessage(messageId: messageId);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
