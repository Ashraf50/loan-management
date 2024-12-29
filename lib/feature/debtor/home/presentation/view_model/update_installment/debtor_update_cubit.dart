import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/debtor_installment_model.dart';
part 'debtor_update_state.dart';

class DebtorUpdateCubit extends Cubit<DebtorUpdateState> {
  DebtorUpdateCubit() : super(DebtorUpdateInitial());
  void updateMonthStatus(
      DebtorInstallmentModel installment, int index, bool isCompleted) {
    try {
      installment.completedMonths[index] = isCompleted;
      if (isCompleted) {
        installment.totalPaid += installment.installmentValue;
      } else {
        installment.totalPaid -= installment.installmentValue;
      }
      installment.save();
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateFailure(e.toString()));
    }
  }

  void updateMonthNotes(
      DebtorInstallmentModel installment, int index, String? note) {
    try {
      installment.monthNotes[index] = note;
      installment.save();
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateFailure(e.toString()));
    }
  }

  bool canRemoveMark(DebtorInstallmentModel installment) {
    if (installment.lastChangeStatus != null) {
      final timeDiff = DateTime.now().difference(installment.lastChangeStatus!);
      return timeDiff.inHours < 1;
    }
    return true;
  }
}
