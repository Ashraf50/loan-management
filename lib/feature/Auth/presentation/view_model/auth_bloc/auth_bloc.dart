import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      final supabase = Supabase.instance.client;
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          // Create a user with Supabase
          final response = await supabase.auth.signUp(
            email: event.email,
            password: event.password,
          );
          if (response.user == null) {
            throw Exception('Failed to register user');
          }
          String table = event.role == 'Debtor' || event.role == 'مدين'
              ? 'Debtors'
              : event.role == 'Creditor' || event.role == 'دائن'
                  ? 'Creditors'
                  : throw Exception("Invalid role selected");
          // Check if the email already exists in the other table
          String otherTable = table == 'Debtors' ? 'Creditors' : 'Debtors';
          final existingUser = await supabase
              .from(otherTable)
              .select('id')
              .eq('email', event.email)
              .maybeSingle();

          if (existingUser != null) {
            emit(RegisterFailure(
                messageError: "email-already-registered-in-other-role"));
            return;
          }
          // Add user to the appropriate table
          await supabase.from(table).insert({
            'Uid': response.user!.id,
            'Username': event.username,
            'email': event.email,
            'phone': event.phoneNumber,
            'password': event.password,
            'role': event.role,
          });
          emit(RegisterSuccess());
        } catch (e) {
          emit(RegisterFailure(messageError: e.toString()));
        }
      } else if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          final response =
              await Supabase.instance.client.auth.signInWithPassword(
            email: event.email,
            password: event.password,
          );
          if (response.error != null) {
            emit(LoginFailure(message: response.error!.message));
            return;
          }
          final role = event.role;
          final selectedTable = role == 'Debtor' || role == 'مدين'
              ? 'Debtors'
              : role == 'Creditor' || role == 'دائن'
                  ? 'Creditors'
                  : null;
          if (selectedTable == null) {
            emit(LoginFailure(message: "Invalid role selected"));
            return;
          }
          try {
            // ignore: unused_local_variable
            final queryResponse = await Supabase.instance.client
                .from(selectedTable)
                .select()
                .eq('email', event.email)
                .single();
            final pref = await SharedPreferences.getInstance();
            await pref.setString('userRole', event.role);
            emit(LoginSuccess(role: role));
            return;
          } catch (e) {
            final otherTable =
                selectedTable == 'Debtors' ? 'Creditors' : 'Debtors';
            try {
              // ignore: unused_local_variable
              final otherQueryResponse = await Supabase.instance.client
                  .from(otherTable)
                  .select()
                  .eq('email', event.email)
                  .single();
              emit(
                  LoginFailure(message: "Email is registered in another role"));
              return;
            } catch (e) {
              emit(LoginFailure(message: "User not found in selected role"));
              return;
            }
          }
        } on Exception catch (e) {
          emit(LoginFailure(message: "Something went wrong ${e.toString()}"));
        }
      } else if (event is ResetEvent) {
        emit(ResetLoading());
        try {
          // Send password reset email with Supabase
          await supabase.auth.resetPasswordForEmail(event.email);
          emit(ResetSuccess());
        } catch (e) {
          emit(ResetFailure(messageError: e.toString()));
        }
      } else if (event is UpdatePassEvent) {
        emit(UpdatePassLoading());
        try {
          // ignore: unused_local_variable
          final recovery = await supabase.auth.verifyOTP(
            token: event.token,
            email: event.email,
            type: OtpType.recovery,
          );

          await supabase.auth
              .updateUser(UserAttributes(password: event.password));
          try {
            bool isDebtor = await AuthHelper().isDebtor();
            String table = isDebtor ? "Debtors" : "Creditors";
            await supabase.from(table).update({
              'password': event.password,
            }).eq('Uid', supabase.auth.currentUser!.id);
          } catch (e) {
            emit(UpdatePassFailure(
                messageError: "Error updating password ${e.toString()}"));
          }
          emit(UpdatePassSuccess());
        } catch (e) {
          emit(UpdatePassFailure(messageError: e.toString()));
        }
      }
    });
  }
}

extension on PostgrestMap {
  get error => null;

  get data => null;
}

extension on AuthResponse {
  get error => null;
}
