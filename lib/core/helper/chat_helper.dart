import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';

class ChatHelper {
  static Future<String> fetchChatTitle(
      String currentUserId, String otherUserId) async {
    try {
      bool isCurrentUserDebtor = await AuthHelper().isDebtor();
      String searchTable = isCurrentUserDebtor ? "Creditors" : "Debtors";

      final response = await Supabase.instance.client
          .from(searchTable)
          .select('Username')
          .eq('Uid', otherUserId)
          .single();
      return response['Username'] ?? "Unknown User";
    } catch (e) {
      print("Error fetching chat title: $e");
      return "Unknown User";
    }
  }
  static String getInitials(String name) {
  List<String> words = name.split(' ');
  if (words.isEmpty) return '';
  String firstInitial = words[0][0];
  String secondInitial = words.length > 1 ? words[1][0] : '';
  return '$firstInitial$secondInitial'.toUpperCase();
}
}
