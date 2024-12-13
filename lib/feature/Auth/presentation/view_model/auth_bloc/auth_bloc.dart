import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          final user =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          CollectionReference selectedCollection;
          CollectionReference otherCollection;

          if (event.role == 'Debtor' || event.role == 'مدين') {
            selectedCollection =
                FirebaseFirestore.instance.collection("Debtors");
            otherCollection =
                FirebaseFirestore.instance.collection("Creditors");
          } else if (event.role == 'Creditor' || event.role == 'دائن') {
            selectedCollection =
                FirebaseFirestore.instance.collection("Creditors");
            otherCollection = FirebaseFirestore.instance.collection("Debtors");
          } else {
            throw Exception("Invalid role selected");
          }
          // Check if the email already exists in the other collection
          final querySnapshot = await otherCollection
              .where('email', isEqualTo: event.email)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            emit(RegisterFailure(
                messageError: "email-already-registered-in-other-role"));
            return;
          }
          // Add user to the selected collection
          await selectedCollection.doc(user.user!.uid).set({
            'Username': event.username,
            'email': event.email,
            'phone': event.phoneNumber,
            'password': event.password,
            'role': event.role,
          });
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(messageError: 'weak-password'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(messageError: 'email-already-in-use'));
          } else {
            emit(RegisterFailure(messageError: e.code));
          }
        } on Exception catch (_) {
          emit(RegisterFailure(messageError: "something went wrong"));
        }
      } else if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          CollectionReference selectedCollection;
          CollectionReference otherCollection;
          if (event.role == 'Debtor' || event.role == 'مدين') {
            selectedCollection =
                FirebaseFirestore.instance.collection('Debtors');
            otherCollection =
                FirebaseFirestore.instance.collection('Creditors');
          } else if (event.role == 'Creditor' || event.role == 'دائن') {
            selectedCollection =
                FirebaseFirestore.instance.collection('Creditors');
            otherCollection = FirebaseFirestore.instance.collection('Debtors');
          } else {
            emit(LoginFailure(message: "Invalid role selected"));
            return;
          }
          final selectedDoc =
              await selectedCollection.doc(user.user!.uid).get();
          if (selectedDoc.exists) {
            emit(LoginSuccess(role: event.role));
          } else {
            // Check if the user is registered in the other collection
            final otherDoc = await otherCollection.doc(user.user!.uid).get();
            if (otherDoc.exists) {
              emit(LoginFailure(
                  message: "Email is not registered as ${event.role}"));
            } else {
              emit(LoginFailure(message: "User not found in selected role"));
            }
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(message: "user-not-found"));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(message: "wrong-password"));
          } else {
            emit(LoginFailure(message: e.code));
          }
        } on Exception {
          emit(LoginFailure(message: "something went wrong"));
        }
      } else if (event is ResetEvent) {
        emit(ResetLoading());
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: event.email);
          emit(ResetSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(ResetFailure(messageError: "user-not-found"));
          } else if (e.code == 'wrong-password') {
            emit(ResetFailure(messageError: 'wrong-password'));
          } else {
            emit(ResetFailure(messageError: e.code));
          }
        } on Exception {
          emit(ResetFailure(messageError: "something went wrong"));
        }
      }
    });
  }
}
