import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../../core/constant/app_string.dart';
import '../../../data/model/installment_model.dart';
import 'installment_state.dart';

class InstallmentCubit extends Cubit<InstallmentState> {
  InstallmentCubit() : super(InstallmentInitial());
  List<InstallmentModel>? allInstallments;
  List<InstallmentModel>? filteredInstallments;
  List<InstallmentModel> completedInstallment = [];

  fetchAllInstallment() {
    var installmentBox = Hive.box<InstallmentModel>(AppStrings.installmentBox);
    allInstallments = installmentBox.values.toList();
    completedInstallment = allInstallments!
        .where((installment) =>
            installment.completedMonths.every((month) => month))
        .toList();
    filteredInstallments = allInstallments
        ?.where((installment) =>
            !installment.completedMonths.every((month) => month))
        .toList();
    emit(InstallmentLoaded());
  }

  add(InstallmentModel installment) async {
    emit(InstallmentLoading());
    try {
      var installmentBox =
          Hive.box<InstallmentModel>(AppStrings.installmentBox);

      if (!installmentBox.containsKey(installment.title)) {
        await installmentBox.put(installment.title, installment);
      } else {
        await installmentBox.put(installment.title, installment);
      }
      emit(InstallmentSuccess());
    } catch (e) {
      emit(InstallmentFailure(errMessage: e.toString()));
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
    emit(InstallmentLoaded());
  }

  void checkAndMoveToCompleted(InstallmentModel installment) async {
    if (installment.completedMonths.every((month) => month)) {
      completedInstallment.add(installment);
      allInstallments?.remove(installment);
      filteredInstallments?.remove(installment);
      var installmentBox =
          Hive.box<InstallmentModel>(AppStrings.installmentBox);
      await installmentBox.delete(installment.title);
      await installmentBox.put(installment.title, installment);
      emit(InstallmentLoaded());
    }
  }
}
