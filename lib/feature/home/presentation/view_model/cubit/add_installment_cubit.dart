import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_installment_state.dart';

class InstallmentCubit extends Cubit<InstallmentState> {
  InstallmentCubit() : super(InstallmentState());

  void addInstallment({
    required String installmentName,
    required String totalAmount,
    required String numOfMonth,
    required String installmentValue,
    required String startDate,
  }) {
    final newInstallment = {
      'installment_name': installmentName,
      'total_amount': totalAmount,
      'num_of_month': numOfMonth,
      'installment_value': installmentValue,
      'start_date': startDate,
    };
    final updatedInstallments =
        List<Map<String, String>>.from(state.installments)..add(newInstallment);
    emit(InstallmentState(installments: updatedInstallments));
  }
}
