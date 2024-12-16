part of 'update_bloc.dart';

sealed class UpdateEvent {}

class UpdateUsernameEvent extends UpdateEvent {
  final String username;
  UpdateUsernameEvent({
    required this.username,
  });
}

class UpdatePhoneEvent extends UpdateEvent {
  final String phone;
  UpdatePhoneEvent({
    required this.phone,
  });
}
