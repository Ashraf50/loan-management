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
}
