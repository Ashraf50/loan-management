import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<UpdateEvent>((event, emit) async {
      bool isDebtor = await AuthHelper().isDebtor();
      String table = isDebtor ? "Debtors" : "Creditors";
      final supabase = Supabase.instance.client;
      if (event is UpdateUsernameEvent) {
        emit(UpdateUsernameLoading());
        try {
          await supabase.from(table).update({
            'Username': event.username,
          }).eq('Uid', supabase.auth.currentUser!.id);
          emit(UpdateUsernameSuccess());
        } catch (e) {
          emit(UpdateUsernameFailure(errMessage: e.toString()));
        }
      } else if (event is UpdatePhoneEvent) {
        emit(UpdatePhoneLoading());
        try {
          await supabase.from(table).update({
            'phone': event.phone,
          }).eq('Uid', supabase.auth.currentUser!.id);
          emit(UpdatePhoneSuccess());
        } catch (e) {
          emit(UpdatePhoneFailure(errMessage: e.toString()));
        }
      }
    });
  }
}
