import 'package:loan_management/feature/chat/data/model/chat_model.dart';
import 'package:loan_management/feature/chat/data/model/message.dart';

abstract class ChatRepo {
  Future<List<ChatModel>> getALlChats();
  Future<List<MessageModel>> getMessages({
    required String user1Id,
    required String user2Id,
  });
  Future <String> getChatID({
    required String user1Id,
    required String user2Id,
  });
}
