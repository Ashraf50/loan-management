sealed class CreditorInstallmentState {}

final class CreditorInstallmentInitial extends CreditorInstallmentState {}

final class CreditorInstallmentLoading extends CreditorInstallmentState {}

final class CreditorInstallmentSuccess extends CreditorInstallmentState {}

final class CreditorInstallmentFailure extends CreditorInstallmentState {
  final String errMessage;
  CreditorInstallmentFailure({
    required this.errMessage,
  });
}

class CreditorInstallmentLoaded extends CreditorInstallmentState {}
