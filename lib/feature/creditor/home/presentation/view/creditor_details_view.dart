import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/feature/creditor/home/data/model/creditor_installment_model.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/creditor_details_view_body.dart';
import '../view_model/update_installment/creditor_update_cubit.dart';

class CreditorDetailsView extends StatelessWidget {
  final CreditorInstallmentModel creditorInstallmentModel;
  const CreditorDetailsView({
    super.key,
    required this.creditorInstallmentModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditorUpdateCubit(),
      child: CreditorDetailsViewBody(
        installment: creditorInstallmentModel,
      ),
    );
  }
}
