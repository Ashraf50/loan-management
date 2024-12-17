import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/show_snack_bar.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_dialog_widget.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_completed_installment_list_view.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/sliver_app_bar.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_uncompleted_installment_list_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../core/constant/get_responsive.dart';
import '../../../../../../generated/l10n.dart';
import '../../view_model/cubit/debtor_installment_cubit.dart';
import '../../view_model/cubit/debtor_installment_state.dart';

class DebtorHomeViewBody extends StatelessWidget {
  const DebtorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenHeight = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.primaryColor,
                scrolledUnderElevation: 0,
                pinned: true,
                floating: true,
                expandedHeight: getResponsiveHeight(screenHeight),
                flexibleSpace:
                    const FlexibleSpaceBar(background: SliverAppBarWidget()),
                bottom: TabBar(
                  labelPadding: EdgeInsets.zero,
                  labelColor: Colors.white,
                  labelStyle: AppStyles.textStyle20notBold,
                  indicatorColor: AppColors.white,
                  unselectedLabelStyle: AppStyles.textStyle18White,
                  dividerHeight: 0,
                  tabs: [
                    Tab(text: S.of(context).Uncompleted_Install),
                    Tab(text: S.of(context).completed_Install),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              DebtorUnCompletedInstallmentListView(),
              DebtorCompletedInstallmentListView(),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            showDialogWidget(context, themeProvider);
          },
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryColor,
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  void showDialogWidget(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<DebtorInstallmentCubit, DebtorInstallmentState>(
          listener: (context, state) {
            if (state is DebtorInstallmentSuccess) {
              BlocProvider.of<DebtorInstallmentCubit>(context)
                  .fetchAllInstallment();
              Navigator.pop(context);
            } else if (state is DebtorInstallmentFailure) {
              showSnackBar(context, state.errMessage);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is DebtorInstallmentLoading ? true : false,
              child: const DebtorDialogWidget(),
            );
          },
        );
      },
    );
  }
}
