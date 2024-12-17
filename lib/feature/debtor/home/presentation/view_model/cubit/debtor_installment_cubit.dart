import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../../../core/constant/app_string.dart';
import '../../../data/model/debtor_installment_model.dart';
import 'debtor_installment_state.dart';

class DebtorInstallmentCubit extends Cubit<DebtorInstallmentState> {
  DebtorInstallmentCubit() : super(DebtorInstallmentInitial());
  List<DebtorInstallmentModel>? allInstallments;
  List<DebtorInstallmentModel>? filteredInstallments;
  List<DebtorInstallmentModel> completedInstallment = [];

  fetchAllInstallment() {
    var installmentBox =
        Hive.box<DebtorInstallmentModel>(AppStrings.debtorInstallmentBox);
    allInstallments = installmentBox.values.toList();
    completedInstallment = allInstallments!
        .where((installment) =>
            installment.completedMonths.every((month) => month))
        .toList();
    filteredInstallments = allInstallments
        ?.where((installment) =>
            !installment.completedMonths.every((month) => month))
        .toList();
    emit(DebtorInstallmentLoaded());
  }

  add(DebtorInstallmentModel installment) async {
    emit(DebtorInstallmentLoading());
    try {
      var installmentBox =
          Hive.box<DebtorInstallmentModel>(AppStrings.debtorInstallmentBox);

      if (!installmentBox.containsKey(installment.title)) {
        await installmentBox.put(installment.title, installment);
      } else {
        await installmentBox.put(installment.title, installment);
      }
      emit(DebtorInstallmentSuccess());
    } catch (e) {
      emit(DebtorInstallmentFailure(errMessage: e.toString()));
    }
  }

  searchInstallments(String query) {
    if (query.isEmpty) {
      filteredInstallments = List.from(allInstallments!);
    } else {
      filteredInstallments = allInstallments!
          .where((installment) =>
              installment.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(DebtorInstallmentLoaded());
  }

  void checkAndMoveToCompleted(DebtorInstallmentModel installment) async {
    if (installment.completedMonths.every((month) => month)) {
      completedInstallment.add(installment);
      allInstallments?.remove(installment);
      filteredInstallments?.remove(installment);
      var installmentBox =
          Hive.box<DebtorInstallmentModel>(AppStrings.debtorInstallmentBox);
      await installmentBox.delete(installment.title);
      await installmentBox.put(installment.title, installment);
      emit(DebtorInstallmentLoaded());
    }
  }
}
