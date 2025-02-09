import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  Future<void> addInstallmentById(String installmentId) async {
    final supabaseClient = Supabase.instance.client;
    try {
      final response = await supabaseClient
          .from('installments')
          .select('*')
          .eq('Uid', installmentId)
          .single();
      _addInstallmentToDebtor(response);
      emit(DebtorInstallmentSuccess());
    } catch (e) {
      throw Exception('Error fetching installment by ID: $e');
    }
  }

  Future<void> _addInstallmentToDebtor(Map<String, dynamic> installment) async {
    try {
      var debtorInstallmentsBox =
          Hive.box<DebtorInstallmentModel>(AppStrings.debtorInstallmentBox);
      var debtorInstallment = DebtorInstallmentModel(
        title: installment['installment_name'],
        totalAmount: installment['total_amount'],
        numOfMonths: installment['number_of_months'],
        installmentValue: installment['installment_value'],
        startDate: DateTime.parse(installment['start_date']),
        completedMonths: List<bool>.from(
          installment['completed_months'],
        ),
        monthNotes: List<String>.from(
          (installment['month_notes'] ?? []).map((note) => note ?? ""),
        ),
        totalPaid: installment['total_paid'],
        isShared: true,
        id: installment['Uid'],
        creditorId: installment['creditor_id'],
      );
      print(debtorInstallment);
      await debtorInstallmentsBox.put(
          debtorInstallment.title, debtorInstallment);
    } catch (e) {
      throw Exception('Error adding installment to debtor: $e');
    }
  }
}
