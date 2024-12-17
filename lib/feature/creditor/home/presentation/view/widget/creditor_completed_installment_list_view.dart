import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/creditor_animated_list_view.dart';
import 'package:loan_management/feature/creditor/home/presentation/view_model/cubit/creditor_installment_state.dart';
import 'package:loan_management/generated/l10n.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../debtor/home/presentation/view/widget/decoration_container.dart';
import '../../view_model/cubit/creditor_installment_cubit.dart';

class CreditorCompletedInstallmentListView extends StatelessWidget {
  const CreditorCompletedInstallmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditorInstallmentCubit, CreditorInstallmentState>(
      builder: (context, state) {
        if (state is CreditorInstallmentLoaded) {
          final displayedInstallments =
              context.read<CreditorInstallmentCubit>().completedInstallment;
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
                      return CreditorAnimatedInstallmentItem(
                        delay: index * 200,
                        installment: displayedInstallments[index],
                        onTap: () {
                          // context.push(
                          //   "/details_view",
                          //   extra: displayedInstallments[index],
                          // );
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
