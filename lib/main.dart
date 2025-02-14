import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loan_management/core/constant/app_string.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/constant/shared_pref.dart';
import 'feature/creditor/home/data/model/creditor_installment_model.dart';
import 'feature/debtor/home/data/model/debtor_installment_model.dart';
import 'feature/routing/app_router.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeServices();
  runApp(await _buildApp());
}

Future<void> _initializeServices() async {
  await dotenv.load(fileName: ".env");
  await Future.wait([
    _initMobileAds(),
    _initSupabase(),
    _initHive(),
    _initSharedPreferences(),
  ]);
}

Future<void> _initMobileAds() async {
  await MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    testDeviceIds: ['3D40C4DDAD03B6845A96D577C9DDDA98'],
  ));
}

Future<void> _initSupabase() async {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DebtorInstallmentModelAdapter());
  Hive.registerAdapter(CreditorInstallmentModelAdapter());
  await Future.wait([
    Hive.openBox<DebtorInstallmentModel>(AppStrings.debtorInstallmentBox),
    Hive.openBox('offline_updates'),
    Hive.openBox<CreditorInstallmentModel>(AppStrings.creditorInstallment),
  ]);
}

Future<void> _initSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

Future<Widget> _buildApp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool storedValue = pref.getBool('boolValue') ?? false;
  bool isLoggedIn = AuthHelper().loginStatus();
  bool debtorRole = await AuthHelper().isDebtor();
  final appRouter = AppRouter(isLoggedIn: isLoggedIn, isDebtor: debtorRole);
  return ChangeNotifierProvider(
    create: (context) => ThemeProvider(isDarkTheme: storedValue),
    child: MyApp(appRouter: appRouter),
  );
}
