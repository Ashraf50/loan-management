import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loan_management/core/constant/app_string.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:loan_management/feature/home/data/model/installment_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constant/shared_pref.dart';
import 'feature/routing/app_router.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppStrings.supabaseUrl,
    anonKey: AppStrings.supabaseAnon,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(InstallmentModelAdapter());
  await Hive.openBox<InstallmentModel>(AppStrings.installmentBox);
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
