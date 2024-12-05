import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/feature/home/presentation/view/widget/animated_list_view.dart';
import 'package:loan_management/feature/home/presentation/view/widget/decoration_container.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/cubit/installment_cubit.dart';
import '../../view_model/cubit/installment_state.dart';

class InstallmentListView extends StatelessWidget {
  const InstallmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstallmentCubit, InstallmentState>(
      builder: (context, state) {
        if (state is InstallmentLoaded || state is InstallmentInitial) {
          final displayedInstallments =
              context.read<InstallmentCubit>().filteredInstallments ?? [];
          return DecorationContainer(
            widget: displayedInstallments.isEmpty
                ? Center(
                    child: Text(
                      S.of(context).no_installment,
                      style: AppStyles.textStyle20,
                    ),
                  )
                : ListView.builder(
                    itemCount: displayedInstallments.length,
                    itemBuilder: (context, index) {
                      return AnimatedInstallmentItem(
                        delay: index * 200,
                        installment: displayedInstallments[index],
                        onTap: () {
                          context.push("/details_view");
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
