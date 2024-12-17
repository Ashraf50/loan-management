import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loan_management/feature/creditor/home/data/model/creditor_installment_model.dart';
import '../../../../../../core/constant/app_string.dart';
import 'creditor_installment_state.dart';

class CreditorInstallmentCubit extends Cubit<CreditorInstallmentState> {
  CreditorInstallmentCubit() : super(CreditorInstallmentInitial());
  List<CreditorInstallmentModel>? allInstallments;
  List<CreditorInstallmentModel>? filteredInstallments;
  List<CreditorInstallmentModel> completedInstallment = [];

  fetchAllInstallment() {
    var installmentBox =
        Hive.box<CreditorInstallmentModel>(AppStrings.creditorInstallment);
    allInstallments = installmentBox.values.toList();
    completedInstallment = allInstallments!
        .where((installment) =>
            installment.completedMonths.every((month) => month))
        .toList();
    filteredInstallments = allInstallments
        ?.where((installment) =>
            !installment.completedMonths.every((month) => month))
        .toList();
    emit(CreditorInstallmentLoaded());
  }

  add(CreditorInstallmentModel installment) async {
    emit(CreditorInstallmentLoading());
    try {
      var installmentBox =
          Hive.box<CreditorInstallmentModel>(AppStrings.creditorInstallment);

      if (!installmentBox.containsKey(installment.title)) {
        await installmentBox.put(installment.title, installment);
      } else {
        await installmentBox.put(installment.title, installment);
      }
      emit(CreditorInstallmentSuccess());
    } catch (e) {
      emit(CreditorInstallmentFailure(errMessage: e.toString()));
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
    emit(CreditorInstallmentLoaded());
  }

  void checkAndMoveToCompleted(CreditorInstallmentModel installment) async {
    if (installment.completedMonths.every((month) => month)) {
      completedInstallment.add(installment);
      allInstallments?.remove(installment);
      filteredInstallments?.remove(installment);
      var installmentBox =
          Hive.box<CreditorInstallmentModel>(AppStrings.creditorInstallment);
      await installmentBox.delete(installment.title);
      await installmentBox.put(installment.title, installment);
      emit(CreditorInstallmentLoaded());
    }
  }
}
