import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../../core/constant/app_string.dart';
import '../../../data/model/installment_model.dart';
import 'add_installment_state.dart';

class InstallmentCubit extends Cubit<InstallmentState> {
  InstallmentCubit() : super(InstallmentInitial());
  List<InstallmentModel>? allInstallments;
  fetchAllInstallment() {
    var installmentBox = Hive.box<InstallmentModel>(AppStrings.installmentBox);
    allInstallments = installmentBox.values.toList();
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
}
