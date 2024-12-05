sealed class InstallmentState {}

final class InstallmentInitial extends InstallmentState {}

final class InstallmentLoading extends InstallmentState {}

final class InstallmentSuccess extends InstallmentState {}

final class InstallmentFailure extends InstallmentState {
  final String errMessage;
  InstallmentFailure({
    required this.errMessage,
  });
}

class InstallmentLoaded extends InstallmentState {}