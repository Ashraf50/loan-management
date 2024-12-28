part of 'creditor_update_cubit.dart';

sealed class CreditorUpdateState {}

final class CreditorUpdateInitial extends CreditorUpdateState {}

class UpdateLoading extends CreditorUpdateState {}

class UpdateSuccess extends CreditorUpdateState {}

class UpdateFailure extends CreditorUpdateState {
  final String errorMessage;
  UpdateFailure(this.errorMessage);
}
