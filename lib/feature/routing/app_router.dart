import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/bottom_bar.dart';
import 'package:loan_management/feature/menu/presentation/view/widget/about_view.dart';
import 'package:loan_management/feature/menu/presentation/view/widget/language_view.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/bottomBar',
    routes: [
      GoRoute(
        path: '/bottomBar',
        builder: (context, state) => const BottomBar(),
      ),
      GoRoute(
        path: '/language_view',
        builder: (context, state) => const LanguageView(),
      ),
      GoRoute(
        path: '/about_view',
        builder: (context, state) => const AboutView(),
      ),
    ],
  );
}
