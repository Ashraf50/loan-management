import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/feature/creditor/graph/presentation/view/creditor_graph_view.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/creditor_home_view.dart';
import 'package:loan_management/feature/debtor/graph/presentation/view/debtor_graph_view.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/debtor_home_view.dart';
import 'package:loan_management/feature/settings/presentation/view/setting_view.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../generated/l10n.dart';

class DebtorBottomBar extends StatefulWidget {
  const DebtorBottomBar({super.key});

  @override
  State<DebtorBottomBar> createState() => _DebtorBottomBarState();
}

class _DebtorBottomBarState extends State<DebtorBottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DebtorHomeView(),
    DebtorGraphView(),
    SettingView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkTheme = themeProvider.isDarkTheme;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          _buildBottomBarItem(
            iconPath: 'assets/img/home.svg',
            activeIconPath: 'assets/img/active_home.svg',
            title: S.of(context).home,
            isDarkTheme: isDarkTheme,
          ),
          _buildBottomBarItem(
            iconPath: 'assets/img/graph.svg',
            activeIconPath: 'assets/img/graph.svg',
            title: S.of(context).graph,
            isDarkTheme: isDarkTheme,
          ),
          _buildBottomBarItem(
            iconPath: 'assets/img/settings.svg',
            activeIconPath: 'assets/img/active_settings.svg',
            title: S.of(context).setting,
            isDarkTheme: isDarkTheme,
          ),
        ],
      ),
    );
  }
}

class CreditorBottomBar extends StatefulWidget {
  const CreditorBottomBar({super.key});

  @override
  State<CreditorBottomBar> createState() => _CreditorBottomBarState();
}

class _CreditorBottomBarState extends State<CreditorBottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    CreditorHomeView(),
    CreditorGraphView(),
    SettingView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkTheme = themeProvider.isDarkTheme;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          _buildBottomBarItem(
            iconPath: 'assets/img/home.svg',
            activeIconPath: 'assets/img/active_home.svg',
            title: S.of(context).home,
            isDarkTheme: isDarkTheme,
          ),
          _buildBottomBarItem(
            iconPath: 'assets/img/graph.svg',
            activeIconPath: 'assets/img/graph.svg',
            title: S.of(context).graph,
            isDarkTheme: isDarkTheme,
          ),
          _buildBottomBarItem(
            iconPath: 'assets/img/settings.svg',
            activeIconPath: 'assets/img/active_settings.svg',
            title: S.of(context).setting,
            isDarkTheme: isDarkTheme,
          ),
        ],
      ),
    );
  }
}

SalomonBottomBarItem _buildBottomBarItem({
  required String iconPath,
  required String activeIconPath,
  required String title,
  required bool isDarkTheme,
}) {
  final Color iconColor = isDarkTheme ? AppColors.white : AppColors.black;
  final Color selectedColor =
      isDarkTheme ? AppColors.white : AppColors.primaryColor;
  return SalomonBottomBarItem(
    icon: SvgPicture.asset(
      iconPath,
      height: 25,
      colorFilter: ColorFilter.mode(
        iconColor,
        BlendMode.srcIn,
      ),
    ),
    activeIcon: SvgPicture.asset(
      activeIconPath,
      height: 25,
      colorFilter: ColorFilter.mode(
        selectedColor,
        BlendMode.srcIn,
      ),
    ),
    title: Text(title),
    selectedColor: selectedColor,
  );
}
