import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/view/error_page.dart';
import 'package:splity_z/split_details/view/split_details_page.dart';
import 'package:splity_z/splits_list/view/splits_page.dart';

class AppRouter {
  final GoRouter _router;

  AppRouter()
      : _router = GoRouter(
          routes: [
            GoRoute(
              path: '/error',
              builder: (context, state) => const ErrorPage(),
            ),
            GoRoute(
              path: '/split',
              builder: (context, state) => const SplitsPage(),
            ),
            GoRoute(
              path: '/split/:splitId',
              builder: (context, state) {
                String? paramSplitId = state.pathParameters['splitId'];
                int? splitId =
                    paramSplitId != null ? int.parse(paramSplitId) : null;

                if (splitId == null) {
                  return const ErrorPage();
                }

                return SplitDetailsPage(
                  splitId: splitId,
                );
              },
            ),
          ],
        );

  GoRouter get router => _router;

  RouterDelegate<Object> delegate() => _router.routerDelegate;

  RouteInformationParser<Object> defaultRouteParser() =>
      _router.routeInformationParser;
}
