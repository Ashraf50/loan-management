// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_us {
    return Intl.message(
      'About us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Our app is designed to simplify the management of your monthly installments, whether for purchases you've made or for tracking your position in a savings association (جمعية). The app allows you to keep track of the installments due for your purchases, as well as manage your payment and receipt schedule in the association. All of this is available in one app, helping you stay organized and ensuring you keep track of all your financial commitments easily and accurately.`
  String get about_us_body {
    return Intl.message(
      'Our app is designed to simplify the management of your monthly installments, whether for purchases you\'ve made or for tracking your position in a savings association (جمعية). The app allows you to keep track of the installments due for your purchases, as well as manage your payment and receipt schedule in the association. All of this is available in one app, helping you stay organized and ensuring you keep track of all your financial commitments easily and accurately.',
      name: 'about_us_body',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `facebook`
  String get facebook {
    return Intl.message(
      'facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `whatsapp`
  String get whatsapp {
    return Intl.message(
      'whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Graph`
  String get graph {
    return Intl.message(
      'Graph',
      name: 'graph',
      desc: '',
      args: [],
    );
  }

  /// `Installment name`
  String get installment_name {
    return Intl.message(
      'Installment name',
      name: 'installment_name',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get total_amount {
    return Intl.message(
      'Total amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Number of months`
  String get num_of_month {
    return Intl.message(
      'Number of months',
      name: 'num_of_month',
      desc: '',
      args: [],
    );
  }

  /// `Installment value`
  String get installment_value {
    return Intl.message(
      'Installment value',
      name: 'installment_value',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get start_date {
    return Intl.message(
      'Start date',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `Add installment`
  String get add_installment {
    return Intl.message(
      'Add installment',
      name: 'add_installment',
      desc: '',
      args: [],
    );
  }

  /// `Empty value`
  String get empty_value {
    return Intl.message(
      'Empty value',
      name: 'empty_value',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Uncompleted`
  String get Uncompleted_Install {
    return Intl.message(
      'Uncompleted',
      name: 'Uncompleted_Install',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get completed_Install {
    return Intl.message(
      'completed',
      name: 'completed_Install',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Eltzamati`
  String get welcome {
    return Intl.message(
      'Welcome to Eltzamati',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `No installments found.`
  String get no_installment {
    return Intl.message(
      'No installments found.',
      name: 'no_installment',
      desc: '',
      args: [],
    );
  }

  /// `Search for an installment`
  String get Search_for_installment {
    return Intl.message(
      'Search for an installment',
      name: 'Search_for_installment',
      desc: '',
      args: [],
    );
  }

  /// `You must complete the current month`
  String get complete_the_current_month {
    return Intl.message(
      'You must complete the current month',
      name: 'complete_the_current_month',
      desc: '',
      args: [],
    );
  }

  /// `before selecting this month.`
  String get before_selecting_month {
    return Intl.message(
      'before selecting this month.',
      name: 'before_selecting_month',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `note`
  String get note {
    return Intl.message(
      'note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Enter note here...`
  String get enter_note {
    return Intl.message(
      'Enter note here...',
      name: 'enter_note',
      desc: '',
      args: [],
    );
  }

  /// `Amount Paid`
  String get amount_paid {
    return Intl.message(
      'Amount Paid',
      name: 'amount_paid',
      desc: '',
      args: [],
    );
  }

  /// `Remaining amount`
  String get remaining_amount {
    return Intl.message(
      'Remaining amount',
      name: 'remaining_amount',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Months`
  String get remaining_month {
    return Intl.message(
      'Remaining Months',
      name: 'remaining_month',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get months {
    return Intl.message(
      'Months',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `Installment Payment Progress`
  String get graph_title {
    return Intl.message(
      'Installment Payment Progress',
      name: 'graph_title',
      desc: '',
      args: [],
    );
  }

  /// `Amount/Monthly`
  String get amount_monthly {
    return Intl.message(
      'Amount/Monthly',
      name: 'amount_monthly',
      desc: '',
      args: [],
    );
  }

  /// `remaining`
  String get remaining {
    return Intl.message(
      'remaining',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
