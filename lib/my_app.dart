import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/feature/Auth/presentation/view_model/auth_bloc/auth_bloc.dart';
import 'package:loan_management/feature/chat/data/repo/chat_repo_impl.dart';
import 'package:loan_management/feature/debtor/home/presentation/view_model/cubit/debtor_installment_cubit.dart';
import 'package:loan_management/feature/settings/presentation/view_model/language_bloc/language_bloc.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'feature/chat/presentation/view_model/cubit/chats_cubit.dart';
import 'feature/creditor/home/presentation/view_model/cubit/creditor_installment_cubit.dart';
import 'feature/routing/app_router.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(ChatRepoImpl()),
        ),
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) => DebtorInstallmentCubit()..fetchAllInstallment(),
        ),
        BlocProvider(
          create: (context) =>
              CreditorInstallmentCubit()..fetchAllInstallment(),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp.router(
            builder: FlutterSmartDialog.init(),
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
            theme: themeProvider.getThemeData,
            locale: state is AppChangeLanguage ? Locale(state.langCode) : null,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeListResolutionCallback: (deviceLocales, supportedLocales) {
              if (deviceLocales != null) {
                for (var deviceLocale in deviceLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (deviceLocale.languageCode ==
                        supportedLocale.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
              }
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}
