import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/creditor_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../../core/constant/app_colors.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../core/constant/get_responsive.dart';
import '../../../../../../core/widget/show_snack_bar.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../debtor/home/presentation/view/widget/sliver_app_bar.dart';
import '../../view_model/cubit/creditor_installment_cubit.dart';
import '../../view_model/cubit/creditor_installment_state.dart';
import 'creditor_completed_installment_list_view.dart';
import 'creditor_uncompleted_installment_list_view.dart';

class CreditorHomeViewBody extends StatefulWidget {
  const CreditorHomeViewBody({super.key});

  @override
  State<CreditorHomeViewBody> createState() => _CreditorHomeViewBodyState();
}

class _CreditorHomeViewBodyState extends State<CreditorHomeViewBody> {
  void checkInternetAndSync() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      await context
          .read<CreditorInstallmentCubit>()
          .syncLocalDataWithSupabase();
    } else {}
  }

  @override
  void initState() {
    super.initState();
    checkInternetAndSync();
  }

  @override
  Widget build(BuildContext context) {
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
              CreditorUnCompletedInstallmentListView(),
              CreditorCompletedInstallmentListView(),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            showDialogWidget(context);
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

  void showDialogWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<CreditorInstallmentCubit, CreditorInstallmentState>(
          listener: (context, state) {
            if (state is CreditorInstallmentSuccess) {
              BlocProvider.of<CreditorInstallmentCubit>(context)
                  .fetchAllInstallment();
              Navigator.pop(context);
            } else if (state is CreditorInstallmentFailure) {
              showSnackBar(context, state.errMessage);
              print(state.errMessage);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is CreditorInstallmentLoading ? true : false,
              child: const CreditorDialogWidget(),
            );
          },
        );
      },
    );
  }
}
