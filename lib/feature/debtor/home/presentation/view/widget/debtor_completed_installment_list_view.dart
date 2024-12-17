import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/widget/animated_list_view.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/decoration_container.dart';
import '../../../../../../generated/l10n.dart';
import '../../view_model/cubit/installment_cubit.dart';
import '../../view_model/cubit/installment_state.dart';

class DebtorCompletedInstallmentListView extends StatelessWidget {
  const DebtorCompletedInstallmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstallmentCubit, InstallmentState>(
      builder: (context, state) {
        if (state is InstallmentLoaded) {
          final displayedInstallments =
              context.read<InstallmentCubit>().completedInstallment;
          return DecorationContainer(
            widget: displayedInstallments.isEmpty
                ? Center(
                    child: Text(
                      S.of(context).no_installment,
                      style: AppStyles.textStyle20,
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: displayedInstallments.length,
                    itemBuilder: (context, index) {
                      return AnimatedInstallmentItem(
                        delay: index * 200,
                        installment: displayedInstallments[index],
                        onTap: () {
                          context.push(
                            "/details_view",
                            extra: displayedInstallments[index],
                          );
                        },
                      );
                    },
                  ),
          );
        } else {
          return Center(
            child: Text(
              S.of(context).no_installment,
              style: AppStyles.textStyle20,
            ),
          );
        }
      },
    );
  }
}
