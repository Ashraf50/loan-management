import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loan_management/feature/creditor/home/data/model/creditor_installment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  Future<void> add(CreditorInstallmentModel installment) async {
    emit(CreditorInstallmentLoading());
    try {
      var installmentBox =
          Hive.box<CreditorInstallmentModel>(AppStrings.creditorInstallment);
      if (!installmentBox.containsKey(installment.title)) {
        await installmentBox.put(installment.title, installment);
      } else {
        await installmentBox.put(installment.title, installment);
      }
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await _storeInstallmentInSupabase(installment);
      } else {
        print('No internet connection. Data saved locally.');
      }
      emit(CreditorInstallmentSuccess());
    } catch (e) {
      emit(CreditorInstallmentFailure(errMessage: e.toString()));
    }
  }

  Future<void> syncLocalDataWithSupabase() async {
    var installmentBox =
        Hive.box<CreditorInstallmentModel>(AppStrings.creditorInstallment);
    var localData = installmentBox.values
        .where((installment) => installment.isSynced == false)
        .toList();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      for (var installment in localData) {
        try {
          await _storeInstallmentInSupabase(installment);
        } catch (e) {
          print('Failed to sync installment: ${installment.title}. Error: $e');
        }
      }
    } else {
      print('No internet connection. Sync deferred.');
    }
  }

  Future<void> _storeInstallmentInSupabase(
      CreditorInstallmentModel installment) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('installments').insert({
        'Uid': installment.installmentId,
        'debtor_name': installment.installmentDebtor,
        'installment_name': installment.title,
        'total_amount': installment.totalAmount,
        'number_of_months': installment.numOfMonths,
        'installment_value': installment.installmentValue,
        'start_date': installment.startDate.toIso8601String(),
        'completed_months': installment.completedMonths,
        'month_notes': installment.monthNotes,
      });
      var installmentBox =
          Hive.box<CreditorInstallmentModel>(AppStrings.creditorInstallment);
      installment.isSynced = true;
      await installmentBox.put(installment.title, installment);
    } catch (e) {
      print('Failed to store installment in Supabase: $e');
    }
  }

  searchInstallments(String query) {
    if (query.isEmpty) {
      filteredInstallments = List.from(allInstallments!);
    } else {
      filteredInstallments = allInstallments!
          .where((installment) => installment.installmentDebtor
              .toLowerCase()
              .contains(query.toLowerCase()))
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
