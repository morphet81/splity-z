import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/view/view.dart';
import 'package:splity_z/splits/view/view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        initialLocation: '/split',
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
      ),
    );
  }
}
