import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constant/app_colors.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../core/constant/app_theme.dart';
import '../../../../../../core/constant/get_responsive.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../creditor_feature/home/presentation/view/widget/dialog_widget.dart';
import '../../../../../debtor_feature/home/presentation/view/widget/sliver_app_bar.dart';
import 'creditor_completed_installment_list_view.dart';
import 'creditor_uncompleted_installment_list_view.dart';

class CreditorHomeViewBody extends StatelessWidget {
  const CreditorHomeViewBody({super.key});

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
              CreditorUnCompletedInstallmentListView(),
              CreditorCompletedInstallmentListView(),
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
          return const DialogWidget();
        });
  }
}
