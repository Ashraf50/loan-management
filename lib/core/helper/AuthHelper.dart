import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  bool loginStatus() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<bool> isDebtor() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Debtors')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error fetching user role: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    try {
      bool debtorStatus = await isDebtor();
      String collection = debtorStatus ? "Debtors" : "Creditors";
      final userDoc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc.data();
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
