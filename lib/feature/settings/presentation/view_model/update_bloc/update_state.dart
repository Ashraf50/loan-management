part of 'update_bloc.dart';

sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

final class UpdateUsernameLoading extends UpdateState {}

final class UpdateUsernameSuccess extends UpdateState {}

final class UpdateUsernameFailure extends UpdateState {
  final String errMessage;
  UpdateUsernameFailure({required this.errMessage});
}

final class UpdatePhoneLoading extends UpdateState {}

final class UpdatePhoneSuccess extends UpdateState {}

final class UpdatePhoneFailure extends UpdateState {
  final String errMessage;
  UpdatePhoneFailure({required this.errMessage});
}
