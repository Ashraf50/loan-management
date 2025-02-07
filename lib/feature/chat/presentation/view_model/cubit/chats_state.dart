import 'package:loan_management/feature/chat/data/model/chat_model.dart';
import 'package:loan_management/feature/chat/data/model/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatModel> chats;
  ChatLoaded({required this.chats});
}

class ChatError extends ChatState {
  final String errMessage;
  ChatError({
    required this.errMessage,
  });
}

class MessageLoading extends ChatState {}

class MessageLoaded extends ChatState {
  final List<MessageModel> messages;
  MessageLoaded({required this.messages});
}

class MessageError extends ChatState {
  final String errMessage;
  MessageError({
    required this.errMessage,
  });
}

class SendLoading extends ChatState {}

class SendLoaded extends ChatState {
  final String message;
  SendLoaded({required this.message});
}

class SendError extends ChatState {
  final String errMessage;
  SendError({
    required this.errMessage,
  });
}
