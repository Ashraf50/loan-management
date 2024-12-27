import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_animated_list_view.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/decoration_container.dart';
import '../../../../../../generated/l10n.dart';
import '../../view_model/cubit/debtor_installment_cubit.dart';
import '../../view_model/cubit/debtor_installment_state.dart';

class DebtorCompletedInstallmentListView extends StatelessWidget {
  const DebtorCompletedInstallmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtorInstallmentCubit, DebtorInstallmentState>(
      builder: (context, state) {
        if (state is DebtorInstallmentLoaded) {
          final displayedInstallments =
              context.read<DebtorInstallmentCubit>().completedInstallment;
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
                      return DebtorAnimatedInstallmentItem(
                        delay: index * 200,
                        installment: displayedInstallments[index],
                        onTap: () {
                          if (displayedInstallments[index].isShared) {
                            context.push("/shared_details_view");
                          } else {
                            context.push(
                              "/local_details_view",
                              extra: displayedInstallments[index],
                            );
                          }
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
