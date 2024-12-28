import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/model/creditor_installment_model.dart';
part 'creditor_update_state.dart';

class CreditorUpdateCubit extends Cubit<CreditorUpdateState> {
  CreditorUpdateCubit() : super(CreditorUpdateInitial());
  final SupabaseClient supabase = Supabase.instance.client;
  final Box localBox = Hive.box('offline_updates');
  Future<void> updateMonthStatus(
      CreditorInstallmentModel installment, int index, bool isCompleted) async {
    emit(UpdateLoading());
    try {
      installment.completedMonths[index] = isCompleted;
      if (isCompleted) {
        installment.totalPaid += installment.installmentValue;
      } else {
        installment.totalPaid -= installment.installmentValue;
      }
      installment.save();
      final updateData = {
        'completed_months': installment.completedMonths,
        'total_paid': installment.totalPaid,
      };
      _saveOfflineData(installment.installmentId, updateData);
      if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
        await uploadOfflineData();
      }
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateFailure("Connect to internet to upload data."));
    }
  }

  Future<void> updateMonthNotes(
      CreditorInstallmentModel installment, int index, String note) async {
    emit(UpdateLoading());
    try {
      installment.monthNotes[index] = note;
      installment.save();
      final updateData = {'month_notes': installment.monthNotes};
      _saveOfflineData(installment.installmentId, updateData);
      if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
        await uploadOfflineData();
      }
      emit(UpdateSuccess());
    } catch (e) {
      emit(UpdateFailure("Connect to internet to upload data."));
    }
  }

  void _saveOfflineData(String key, Map<String, dynamic> value) {
    final existingData =
        (localBox.get(key) as Map?)?.cast<String, dynamic>() ?? {};
    final updatingData = {...existingData, ...value};
    localBox.put(key, updatingData);
  }

  Future<void> uploadOfflineData() async {
    final pendingData = localBox.toMap();
    for (var entry in pendingData.entries) {
      try {
        await supabase
            .from('installments')
            .update(entry.value)
            .eq('Uid', entry.key);
        localBox.delete(entry.key); // Remove after success
      } catch (e) {
        throw Exception('Error uploading data for ${entry.key}: $e');
      }
    }
  }
}
