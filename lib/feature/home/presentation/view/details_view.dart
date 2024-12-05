import 'package:flutter/material.dart';
import 'package:loan_management/feature/home/presentation/view/widget/details_view_body.dart';
import '../../data/model/installment_model.dart';

class DetailsView extends StatelessWidget {
  final InstallmentModel installment;
  const DetailsView({
    super.key,
    required this.installment,
  });

  @override
  Widget build(BuildContext context) {
    return DetailsViewBody(
      installment: installment,
    );
  }
}
