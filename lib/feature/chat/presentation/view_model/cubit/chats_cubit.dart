import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/feature/chat/data/model/message.dart';
import 'package:loan_management/feature/chat/data/repo/chat_repo_impl.dart';
import '../../../data/repo/chat_service.dart';
import 'chats_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepoImpl chatRepo;
  final ChatService chatService;
  List<MessageModel> messages = [];
  ChatCubit(this.chatRepo, this.chatService) : super(ChatInitial());

  void connectToChat({required String user1Id, required String user2Id}) async {
    emit(MessageLoading());
    try {
      final chatId =
          await chatRepo.getChatID(user1Id: user1Id, user2Id: user2Id);
      chatService.connectSocket(chatId, (data) {
        final newMessage = MessageModel.fromJson(data);
        if (!messages.any((msg) =>
            msg.timestamp == newMessage.timestamp &&
            msg.message == newMessage.message)) {
          messages = [newMessage, ...messages];
          emit(MessageLoaded(messages: List.from(messages)));
        }
      });
      fetchMessages(user1Id: user1Id, user2Id: user2Id);
    } on Exception catch (e) {
      emit(MessageError(errMessage: "Failed to connect to chat: $e"));
    }
  }

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
      final fetchedMessages = await chatRepo.getMessages(
        user1Id: user1Id,
        user2Id: user2Id,
      );
      messages = fetchedMessages;
      emit(MessageLoaded(messages: messages));
    } catch (e) {
      emit(MessageError(errMessage: "Failed to load chats: $e.message}"));
    }
  }

  void sendMessage({required String receiverId, required String message}) {
    chatService.sendMessage(receiverId, message);
  }

  Future removeMessage({required String messageId}) async {
    try {
      await chatRepo.deleteMessage(messageId: messageId);
      messages.removeWhere((msg) => msg.id == messageId);
      emit(MessageLoaded(messages: List.from(messages)));
    } catch (e) {
      emit(MessageError(
          errMessage: "Failed to delete message: ${e.toString()}"));
    }
  }

  Future removeChat({required String chatId}) async {
    try {
      await chatRepo.deleteChat(chatId: chatId);
      fetchChats();
    } catch (e) {
      emit(ChatError(errMessage: "Failed to delete chat: ${e.toString()}"));
    }
  }

  void disconnectSocket() {
    chatService.disconnectSocket();
  }
}
