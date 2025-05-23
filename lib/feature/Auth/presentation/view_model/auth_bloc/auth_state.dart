part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String role;
  LoginSuccess({required this.role});
}

class LoginFailure extends AuthState {
  final String message;
  LoginFailure({
    required this.message,
  });
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String messageError;
  RegisterFailure({
    required this.messageError,
  });
}

class ResetLoading extends AuthState {}

class ResetSuccess extends AuthState {}

class ResetFailure extends AuthState {
  final String messageError;
  ResetFailure({
    required this.messageError,
  });
}

class UpdatePassLoading extends AuthState {}

class UpdatePassSuccess extends AuthState {}

class UpdatePassFailure extends AuthState {
  final String messageError;
  UpdatePassFailure({
    required this.messageError,
  });
}
