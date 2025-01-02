import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/helper/ads_helper.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_completed_installment_list_view.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/sliver_app_bar.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_uncompleted_installment_list_view.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../core/constant/get_responsive.dart';
import '../../../../../../generated/l10n.dart';

class DebtorHomeViewBody extends StatefulWidget {
  const DebtorHomeViewBody({super.key});

  @override
  State<DebtorHomeViewBody> createState() => _DebtorHomeViewBodyState();
}

class _DebtorHomeViewBodyState extends State<DebtorHomeViewBody> {
  BannerAd? banner;
  bool isLoaded = false;
  void loadAd() {
    banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdsHelper.debtorBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    banner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenHeight = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: AppColors.primaryColor,
                    scrolledUnderElevation: 0,
                    pinned: true,
                    floating: true,
                    expandedHeight: getResponsiveHeight(screenHeight),
                    flexibleSpace: const FlexibleSpaceBar(
                        background: SliverAppBarWidget()),
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
            if (isLoaded)
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: banner!.size.height.toDouble(),
                  width: banner!.size.width.toDouble(),
                  child: AdWidget(ad: banner!),
                ),
              ),
          ],
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            _showInstallmentOptions(context, themeProvider.isDarkTheme);
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

  void _showInstallmentOptions(BuildContext context, theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme ? AppColors.widgetColorDark : AppColors.whiteGrey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  S.of(context).add_personal_inst,
                  style: AppStyles.textStyle18black,
                ),
                onTap: () {
                  context.push("/add_local_install");
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.group),
                title: Text(
                  S.of(context).add_shared_inst,
                  style: AppStyles.textStyle18black,
                ),
                onTap: () {
                  context.push("/add_shared_install");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
