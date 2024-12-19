import 'package:flutter/material.dart';
import 'package:loan_management/feature/creditor/home/data/model/creditor_installment_model.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/creditor_details_view_body.dart';

class CreditorDetailsView extends StatelessWidget {
  final CreditorInstallmentModel creditorInstallmentModel;
  const CreditorDetailsView({
    super.key,
    required this.creditorInstallmentModel,
  });

  @override
  Widget build(BuildContext context) {
    return CreditorDetailsViewBody(
      installment: creditorInstallmentModel,
    );
  }
}
