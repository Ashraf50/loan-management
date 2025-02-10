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

  /// `Our application is designed to simplify the management of monthly installments in your daily life, whether for payments related to purchases you've made. The application allows you to track your due installments for purchases, in addition to organizing your monthly payment schedules. All of this in one app that helps you stay organized and ensures you keep track of all your financial commitments accurately and easily.`
  String get about_us_body {
    return Intl.message(
      'Our application is designed to simplify the management of monthly installments in your daily life, whether for payments related to purchases you\'ve made. The application allows you to track your due installments for purchases, in addition to organizing your monthly payment schedules. All of this in one app that helps you stay organized and ensures you keep track of all your financial commitments accurately and easily.',
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

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_pass {
    return Intl.message(
      'Confirm password',
      name: 'confirm_pass',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forget_pass {
    return Intl.message(
      'Forget password?',
      name: 'forget_pass',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get don_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'don_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_pass {
    return Intl.message(
      'Reset password',
      name: 'reset_pass',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forget_password {
    return Intl.message(
      'Forget Password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get set_pass {
    return Intl.message(
      'Set Password',
      name: 'set_pass',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `The password has been successfully changed. Please register again.`
  String get new_pass_message {
    return Intl.message(
      'The password has been successfully changed. Please register again.',
      name: 'new_pass_message',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Password`
  String get please_enter_your_pass {
    return Intl.message(
      'Please enter your Password',
      name: 'please_enter_your_pass',
      desc: '',
      args: [],
    );
  }

  /// `success`
  String get success {
    return Intl.message(
      'success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `warning`
  String get warning {
    return Intl.message(
      'warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get valid_email {
    return Intl.message(
      'Enter a valid email',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `your password is too short`
  String get valid_pass {
    return Intl.message(
      'your password is too short',
      name: 'valid_pass',
      desc: '',
      args: [],
    );
  }

  /// `Check the email or password`
  String get check_email_or_pass {
    return Intl.message(
      'Check the email or password',
      name: 'check_email_or_pass',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `The password does not match`
  String get password_not_match {
    return Intl.message(
      'The password does not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `You cannot leave the field value empty`
  String get value_empty {
    return Intl.message(
      'You cannot leave the field value empty',
      name: 'value_empty',
      desc: '',
      args: [],
    );
  }

  /// `Update Username`
  String get update_username {
    return Intl.message(
      'Update Username',
      name: 'update_username',
      desc: '',
      args: [],
    );
  }

  /// `Update Email`
  String get Update_email {
    return Intl.message(
      'Update Email',
      name: 'Update_email',
      desc: '',
      args: [],
    );
  }

  /// `Update Phone Number`
  String get update_phone {
    return Intl.message(
      'Update Phone Number',
      name: 'update_phone',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_acc {
    return Intl.message(
      'Delete Account',
      name: 'delete_acc',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number`
  String get valid_phone {
    return Intl.message(
      'Enter a valid phone number',
      name: 'valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Debtor`
  String get debtor {
    return Intl.message(
      'Debtor',
      name: 'debtor',
      desc: '',
      args: [],
    );
  }

  /// `Creditor`
  String get creditor {
    return Intl.message(
      'Creditor',
      name: 'creditor',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get save_changes {
    return Intl.message(
      'Save changes',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_info {
    return Intl.message(
      'Personal Information',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Please verify the new email by clicking the link was sent to`
  String get verify_message {
    return Intl.message(
      'Please verify the new email by clicking the link was sent to',
      name: 'verify_message',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for signing up for Eltzamati Please confirm your email address to complete the registration process by clicking the link we sent you.`
  String get verify_email {
    return Intl.message(
      'Thank you for signing up for Eltzamati Please confirm your email address to complete the registration process by clicking the link we sent you.',
      name: 'verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enter_otp {
    return Intl.message(
      'Enter OTP',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Send Otp`
  String get send_otp {
    return Intl.message(
      'Send Otp',
      name: 'send_otp',
      desc: '',
      args: [],
    );
  }

  /// `OTP sended`
  String get otp_sended {
    return Intl.message(
      'OTP sended',
      name: 'otp_sended',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get Username {
    return Intl.message(
      'Username',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get created_at {
    return Intl.message(
      'Created at',
      name: 'created_at',
      desc: '',
      args: [],
    );
  }

  /// `Update data`
  String get update_data {
    return Intl.message(
      'Update data',
      name: 'update_data',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enter_new_pass {
    return Intl.message(
      'Enter new password',
      name: 'enter_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `No user data available`
  String get no_data {
    return Intl.message(
      'No user data available',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Experience seamless management of your finances and commitments. With Eltzamati, you can effortlessly track your dues, installments, and savings in one place.`
  String get splash1 {
    return Intl.message(
      'Experience seamless management of your finances and commitments. With Eltzamati, you can effortlessly track your dues, installments, and savings in one place.',
      name: 'splash1',
      desc: '',
      args: [],
    );
  }

  /// `Never miss a payment again! Our app helps you monitor your progress, set reminders, and keep detailed notes for each installment or commitment.Never miss a payment again! Our app helps you monitor your progress, set reminders, and keep detailed notes for each installment or commitment.`
  String get splash2 {
    return Intl.message(
      'Never miss a payment again! Our app helps you monitor your progress, set reminders, and keep detailed notes for each installment or commitment.Never miss a payment again! Our app helps you monitor your progress, set reminders, and keep detailed notes for each installment or commitment.',
      name: 'splash2',
      desc: '',
      args: [],
    );
  }

  /// `Collaborate easily! Whether you're a debtor or a creditor, Eltzamati enables transparent and efficient communication and record-keeping to make life easier`
  String get splash3 {
    return Intl.message(
      'Collaborate easily! Whether you\'re a debtor or a creditor, Eltzamati enables transparent and efficient communication and record-keeping to make life easier',
      name: 'splash3',
      desc: '',
      args: [],
    );
  }

  /// `Total Inflow`
  String get total_inflow {
    return Intl.message(
      'Total Inflow',
      name: 'total_inflow',
      desc: '',
      args: [],
    );
  }

  /// `Total outflow`
  String get total_outflow {
    return Intl.message(
      'Total outflow',
      name: 'total_outflow',
      desc: '',
      args: [],
    );
  }

  /// `Debtor name`
  String get debtor_name {
    return Intl.message(
      'Debtor name',
      name: 'debtor_name',
      desc: '',
      args: [],
    );
  }

  /// `Shared installment`
  String get shared_install {
    return Intl.message(
      'Shared installment',
      name: 'shared_install',
      desc: '',
      args: [],
    );
  }

  /// `Add personal installment`
  String get add_personal_inst {
    return Intl.message(
      'Add personal installment',
      name: 'add_personal_inst',
      desc: '',
      args: [],
    );
  }

  /// `Add shared installment`
  String get add_shared_inst {
    return Intl.message(
      'Add shared installment',
      name: 'add_shared_inst',
      desc: '',
      args: [],
    );
  }

  /// `Enter installment id`
  String get enter_id {
    return Intl.message(
      'Enter installment id',
      name: 'enter_id',
      desc: '',
      args: [],
    );
  }

  /// `Scan installment`
  String get scan_installment {
    return Intl.message(
      'Scan installment',
      name: 'scan_installment',
      desc: '',
      args: [],
    );
  }

  /// `You cannot change the month status after one hour`
  String get after_change {
    return Intl.message(
      'You cannot change the month status after one hour',
      name: 'after_change',
      desc: '',
      args: [],
    );
  }

  /// `Once an hour has passed, you will not be able to change the month status`
  String get before_change {
    return Intl.message(
      'Once an hour has passed, you will not be able to change the month status',
      name: 'before_change',
      desc: '',
      args: [],
    );
  }

  /// `You cannot un mark this month before un marking the next month.`
  String get remove_mark {
    return Intl.message(
      'You cannot un mark this month before un marking the next month.',
      name: 'remove_mark',
      desc: '',
      args: [],
    );
  }

  /// `Text copied to clipboard!`
  String get copy {
    return Intl.message(
      'Text copied to clipboard!',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection...`
  String get no_internet {
    return Intl.message(
      'No internet connection...',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chat {
    return Intl.message(
      'Chats',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get send_mess {
    return Intl.message(
      'Send Message',
      name: 'send_mess',
      desc: '',
      args: [],
    );
  }

  /// `Copy Message`
  String get copy_mess {
    return Intl.message(
      'Copy Message',
      name: 'copy_mess',
      desc: '',
      args: [],
    );
  }

  /// `Message copied`
  String get mess_copied {
    return Intl.message(
      'Message copied',
      name: 'mess_copied',
      desc: '',
      args: [],
    );
  }

  /// `Delete Message`
  String get delete_mess {
    return Intl.message(
      'Delete Message',
      name: 'delete_mess',
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
