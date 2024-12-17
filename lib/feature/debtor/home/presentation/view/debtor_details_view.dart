import 'package:flutter/material.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_details_view_body.dart';
import '../../data/model/debtor_installment_model.dart';

class DebtorDetailsView extends StatelessWidget {
  final DebtorInstallmentModel installment;
  const DebtorDetailsView({
    super.key,
    required this.installment,
  });

  @override
  Widget build(BuildContext context) {
    return DebtorDetailsViewBody(
      installment: installment,
    );
  }
}
