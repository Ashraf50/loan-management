part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;
  LoginEvent({
    required this.email,
    required this.password,
    required this.role,
  });
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  final String role;
  RegisterEvent({
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.role,
  });
}

class ResetEvent extends AuthEvent {
  final String email;
  ResetEvent({
    required this.email,
  });
}
