import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/feature/chat/data/repo/chat_repo_impl.dart';
import 'chats_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepoImpl chatRepo;
  ChatCubit(this.chatRepo) : super(ChatInitial());

  Future<void> fetchChats() async {
    emit(ChatLoading());
    try {
      final chats = await chatRepo.getALlChats();
      emit(ChatLoaded(chats: chats));
    } catch (e) {
      emit(ChatError(errMessage: "Failed to load chats: $e.message}"));
    }
  }

  Future<void> fetchMessages(
      {required String user1Id, required String user2Id}) async {
    emit(MessageLoading());
    try {
      final messages =
          await chatRepo.getMessages(user1Id: user1Id, user2Id: user2Id);
      emit(MessageLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(errMessage: "Failed to load chats: $e.message}"));
    }
  }

  Future<void> sendMessage(
      {required String receiverId, required String message}) async {
    emit(SendLoading());
    try {
      final result = await chatRepo.sendMessage(
        receiverId: receiverId,
        message: message,
      );
      if (result["status"] == false) {
        emit(SendError(errMessage: result['message']));
      } else if (result['status'] == true) {
        emit(SendLoaded(message: result['message']));
      }
    } catch (e) {
      emit(SendError(errMessage: "Failed to send"));
    }
  }
}
