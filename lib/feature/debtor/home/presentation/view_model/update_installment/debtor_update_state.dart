part of 'debtor_update_cubit.dart';

sealed class DebtorUpdateState {}

final class DebtorUpdateInitial extends DebtorUpdateState {}

class UpdateLoading extends DebtorUpdateState {}

class UpdateSuccess extends DebtorUpdateState {}

class UpdateFailure extends DebtorUpdateState {
  final String errorMessage;
  UpdateFailure(this.errorMessage);
}
