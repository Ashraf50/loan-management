import 'package:supabase_flutter/supabase_flutter.dart';

class AuthHelper {
  final supabase = Supabase.instance.client;

  bool loginStatus() {
    return supabase.auth.currentUser != null;
  }

  Future<bool> isDebtor() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      return false;
    }
    try {
      final response = await supabase
          .from('Debtors')
          .select('email')
          .eq('email', user.email as Object)
          .maybeSingle();
      if (response == null) {
        return false;
      }
      return true;
    } catch (e) {
      print("Error fetching user role: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchUserData() async {
    final user = supabase.auth.currentUser;
    try {
      bool debtorStatus = await isDebtor();
      String table = debtorStatus ? "Debtors" : "Creditors";
      final response = await supabase.from(table).select().eq('Uid', user!.id);
      return response;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchInstallmentData(String id) async {
    try {
      final response =
          await supabase.from("installments").select().eq('Uid', id);
      return response;
    } catch (e) {
      print("Error fetching installment details:$e");
      return null;
    }
  }
}
