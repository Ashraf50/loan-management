sealed class DebtorInstallmentState {}

final class DebtorInstallmentInitial extends DebtorInstallmentState {}

final class DebtorInstallmentLoading extends DebtorInstallmentState {}

final class DebtorInstallmentSuccess extends DebtorInstallmentState {}

final class DebtorInstallmentFailure extends DebtorInstallmentState {
  final String errMessage;
  DebtorInstallmentFailure({
    required this.errMessage,
  });
}

class DebtorInstallmentLoaded extends DebtorInstallmentState {}