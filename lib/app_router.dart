import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/view/error_page.dart';
import 'package:splity_z/splits_list/view/splits_page.dart';
import 'package:splity_z/split_details/view/split_details_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/split',
    routes: [
      GoRoute(
        path: '/split',
        builder: (context, state) => const SplitsPage(),
      ),
      GoRoute(
        path: '/split/:splitId',
        builder: (context, state) {
          final paramSplitId = state.pathParameters['splitId'];
          // final splitId =
          //     paramSplitId != null ? int.tryParse(paramSplitId) : null;

          if (paramSplitId == null) {
            return const ErrorPage();
          }

          return SplitDetailsPage(
            splitId: paramSplitId,
          );
        },
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) => const ErrorPage(),
      ),
    ],
  );
}
