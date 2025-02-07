import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loan_management/core/constant/app_string.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:loan_management/feature/debtor/home/data/model/debtor_installment_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constant/shared_pref.dart';
import 'feature/creditor/home/data/model/creditor_installment_model.dart';
import 'feature/routing/app_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    testDeviceIds: ['3D40C4DDAD03B6845A96D577C9DDDA98'],
  ));
  await Hive.initFlutter();
  Hive.registerAdapter(DebtorInstallmentModelAdapter());
  Hive.registerAdapter(CreditorInstallmentModelAdapter());
  await Hive.openBox<DebtorInstallmentModel>(AppStrings.debtorInstallmentBox);
  await Hive.openBox('offline_updates');
  await Hive.openBox<CreditorInstallmentModel>(AppStrings.creditorInstallment);
  sharedPreferences = await SharedPreferences.getInstance(); //save language
  SharedPreferences pref = await SharedPreferences.getInstance(); //save theme
  bool storedValue = pref.getBool('boolValue') ?? false;
  bool isLoggedIn = AuthHelper().loginStatus();
  bool debtorRole = await AuthHelper().isDebtor();
  final appRouter = AppRouter(isLoggedIn: isLoggedIn, isDebtor: debtorRole);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(isDarkTheme: storedValue),
      child: MyApp(
        appRouter: appRouter,
      ),
    ),
  );
}
