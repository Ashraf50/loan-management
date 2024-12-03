class InstallmentState {
  final List<Map<String, String>> installments;
  InstallmentState({this.installments = const []});

  InstallmentState copyWith({List<Map<String, String>>? installments}) {
    return InstallmentState(
      installments: installments ?? this.installments,
    );
  }
}