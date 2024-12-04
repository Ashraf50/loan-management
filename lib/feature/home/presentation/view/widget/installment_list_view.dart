import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/feature/home/presentation/view/widget/decoration_container.dart';
import 'package:loan_management/feature/home/presentation/view/widget/installment_item.dart';
import '../../../data/model/installment_model.dart';
import '../../view_model/cubit/add_installment_cubit.dart';
import '../../view_model/cubit/add_installment_state.dart';

class InstallmentListView extends StatelessWidget {
  const InstallmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstallmentCubit, InstallmentState>(
      builder: (context, state) {
        List<InstallmentModel> allInstallments =
            BlocProvider.of<InstallmentCubit>(context).allInstallments ?? [];
        return DecorationContainer(
          widget: ListView.builder(
            itemCount: allInstallments.length,
            itemBuilder: (context, index) {
              return InstallmentItem(
                onTap: () {
                  context.push("/details_view");
                },
                installment: allInstallments[index],
              );
            },
          ),
        );
      },
    );
  }
}
