import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/bottom_bar.dart';
import 'package:loan_management/feature/Auth/presentation/view/forget_pass_view.dart';
import 'package:loan_management/feature/Auth/presentation/view/sign_in_view.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/finish_reset_pass_view.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/update_password_view.dart';
import 'package:loan_management/feature/creditor/home/data/model/creditor_installment_model.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/creditor_details_view.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/add_installment.dart';
import 'package:loan_management/feature/debtor/home/data/model/debtor_installment_model.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/add_local_installment.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/scan_installment_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/about_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/language_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/peofile_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/personal_info_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/update_phone_view.dart';
import '../Auth/presentation/view/sign_up_view.dart';
import '../debtor/home/presentation/view/widget/add_shared_installment.dart';
import '../debtor/home/presentation/view/widget/debtor_local_details_view_body.dart';
import '../debtor/home/presentation/view/widget/debtor_shared_details_view_body.dart';
import '../settings/presentation/view/widget/update_username_view.dart';

class AppRouter {
  final bool isLoggedIn;
  final bool isDebtor;
  AppRouter({required this.isLoggedIn, required this.isDebtor});
  late final GoRouter router = GoRouter(
    initialLocation: isLoggedIn
        ? isDebtor
            ? '/DebtorBottomBar'
            : '/CreditorBottomBar'
        : '/signInView',
    routes: [
      GoRoute(
        path: '/DebtorBottomBar',
        builder: (context, state) => const DebtorBottomBar(),
      ),
      GoRoute(
        path: '/CreditorBottomBar',
        builder: (context, state) => const CreditorBottomBar(),
      ),
      GoRoute(
        path: '/signInView',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/signUpView',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/forgetPasswordView',
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: '/updatePasswordView',
        builder: (context, state) => const UpdatePasswordView(),
      ),
      GoRoute(
        path: '/UpdateUsername',
        builder: (context, state) => const UpdateUsernameView(),
      ),
      GoRoute(
        path: '/UpdatePhone',
        builder: (context, state) => const UpdatePhoneView(),
      ),
      GoRoute(
        path: '/finishResetPassword',
        builder: (context, state) => const FinishResetPassView(),
      ),
      GoRoute(
        path: '/language_view',
        builder: (context, state) => const LanguageView(),
      ),
      GoRoute(
        path: '/personalInfo',
        builder: (context, state) => const PersonalInfoView(),
      ),
      GoRoute(
        path: '/profileView',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/about_view',
        builder: (context, state) => const AboutView(),
      ),
      GoRoute(
          path: '/scan_view',
          builder: (context, state) {
            final scan = state.extra as Function(String);
            return ScanInstallmentView(
              onScan: scan,
            );
          }),
      GoRoute(
        path: '/local_details_view',
        builder: (context, state) {
          final installmentDetails = state.extra as DebtorInstallmentModel;
          return DebtorLocalDetailsViewBody(
            installment: installmentDetails,
          );
        },
      ),
      GoRoute(
        path: '/shared_details_view',
        builder: (context, state) {
          final installmentDetails = state.extra as DebtorInstallmentModel;
          return DebtorSharedDetailsViewBody(
            installment: installmentDetails,
          );
        },
      ),
      GoRoute(
        path: '/creditor_details_view',
        builder: (context, state) {
          final installmentDetails = state.extra as CreditorInstallmentModel;
          return CreditorDetailsView(
            creditorInstallmentModel: installmentDetails,
          );
        },
      ),
      GoRoute(
        path: '/add_local_install',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AddLocalInstallment(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/add_shared_install',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AddSharedInstallment(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/add_installment',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AddInstallmentView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
