import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/bottom_bar.dart';
import 'package:loan_management/feature/Auth/presentation/view/forget_pass_view.dart';
import 'package:loan_management/feature/Auth/presentation/view/sign_in_view.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/finish_reset_pass_view.dart';
import 'package:loan_management/feature/home/data/model/installment_model.dart';
import 'package:loan_management/feature/home/presentation/view/details_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/about_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/language_view.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/profile_view.dart';
import '../Auth/presentation/view/sign_up_view.dart';

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
        path: '/finishResetPassword',
        builder: (context, state) => const FinishResetPassView(),
      ),
      GoRoute(
        path: '/language_view',
        builder: (context, state) => const LanguageView(),
      ),
      GoRoute(
        path: '/ProfileView',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/about_view',
        builder: (context, state) => const AboutView(),
      ),
      GoRoute(
        path: '/details_view',
        builder: (context, state) {
          final installmentDetails = state.extra as InstallmentModel;
          return DetailsView(
            installment: installmentDetails,
          );
        },
      ),
    ],
  );
}
