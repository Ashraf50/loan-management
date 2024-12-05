import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../../core/constant/app_string.dart';
import '../../../data/model/installment_model.dart';
import 'installment_state.dart';

class InstallmentCubit extends Cubit<InstallmentState> {
  InstallmentCubit() : super(InstallmentInitial());
  List<InstallmentModel>? allInstallments;
  List<InstallmentModel>? filteredInstallments;

  fetchAllInstallment() {
    var installmentBox = Hive.box<InstallmentModel>(AppStrings.installmentBox);
    allInstallments = installmentBox.values.toList();
    filteredInstallments = List.from(allInstallments!);
    emit(InstallmentLoaded());
  }

  add(InstallmentModel installment) async {
    emit(InstallmentLoading());
    try {
      var installmentBox =
          Hive.box<InstallmentModel>(AppStrings.installmentBox);
      await installmentBox.add(installment);
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
}
