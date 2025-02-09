import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthHelper {
  final supabase = Supabase.instance.client;
  SharedPreferences? pref;
  AuthHelper() {
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  bool loginStatus() {
    return supabase.auth.currentUser != null;
  }

  Future<bool> isDebtor() async {
    if (pref == null) {
      await _initializePreferences();
    }
    String? role = pref?.getString('userRole');
    if (role == "Debtor" || role == "مدين") {
      return true;
    } else {
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
