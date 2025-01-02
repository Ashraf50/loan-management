import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../../../core/constant/app_colors.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../core/constant/get_responsive.dart';
import '../../../../../../core/helper/ads_helper.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../debtor/home/presentation/view/widget/sliver_app_bar.dart';
import '../../view_model/cubit/creditor_installment_cubit.dart';
import 'creditor_completed_installment_list_view.dart';
import 'creditor_uncompleted_installment_list_view.dart';

class CreditorHomeViewBody extends StatefulWidget {
  const CreditorHomeViewBody({super.key});

  @override
  State<CreditorHomeViewBody> createState() => _CreditorHomeViewBodyState();
}

class _CreditorHomeViewBodyState extends State<CreditorHomeViewBody> {
  BannerAd? banner;
  bool isLoaded = false;
  void loadAd() {
    banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdsHelper.creditorBanner,
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
    loadAd();
    checkInternetAndSync();
  }

  @override
  void dispose() {
    banner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  CreditorUnCompletedInstallmentListView(),
                  CreditorCompletedInstallmentListView(),
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
            context.push("/add_installment");
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
}
