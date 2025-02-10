import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loan_management/core/constant/app_string.dart';
import 'package:loan_management/core/helper/api_helper.dart';
import 'package:loan_management/feature/chat/data/model/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/chat_model.dart';
import 'chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  ApiHelper apiHelper = ApiHelper();
  var userId = Supabase.instance.client.auth.currentUser?.id;
  @override
  Future<List<ChatModel>> getALlChats() async {
    try {
      if (userId == null) throw Exception("User not authenticated");
      final response = await apiHelper.get(
        '${AppStrings.chatBaseUrl}/api/chats/$userId?apiKey=${dotenv.env['CHAT_API']}',
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true") {
          return (data['chats'] as List)
              .map((chat) => ChatModel.fromJson(chat))
              .toList();
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Failed to fetch chats: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching chats: $e");
      return [];
    }
  }

  @override
  Future<List<MessageModel>> getMessages({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      final String url =
          '${AppStrings.chatBaseUrl}/api/messages?apiKey=${dotenv.env['CHAT_API']}&user1Id=$user1Id&user2Id=$user2Id&limit=100';
      final response = await apiHelper.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true") {
          return (data['messages'] as List)
              .map((msg) => MessageModel.fromJson(msg))
              .toList();
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Failed to fetch chats: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching chats: $e");
      return [];
    }
  }

  @override
  Future<String> getChatID({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      final response = await apiHelper.get(
        '${AppStrings.chatBaseUrl}/api/chats/?user1Id=$user1Id&user2Id=$user2Id',
      );
      if (response.statusCode == 200 && response.data['status'] == "true") {
        return response.data['chatId'];
      } else {
        throw Exception("Failed to get or create chat.");
      }
    } catch (e) {
      throw Exception("Error getting chatId: $e");
    }
  }

  @override
  Future deleteChat({required String chatId}) async {
    try {
      await apiHelper.delete(
          '${AppStrings.chatBaseUrl}/api/chats/$chatId?apiKey=${dotenv.env['CHAT_API']}');
    } catch (e) {
      throw Exception("Failed to delete message: ${e.toString()}");
    }
  }

  @override
  Future deleteMessage({required String messageId}) async {
    try {
      await apiHelper.delete(
          '${AppStrings.chatBaseUrl}/api/messages/$messageId?apiKey=${dotenv.env['CHAT_API']}');
    } catch (e) {
      throw Exception("Failed to delete message: ${e.toString()}");
    }
  }
}
