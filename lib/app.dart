import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/view/view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splity_z/splits_list/view/splits_page.dart';
import 'package:splity_z/split_details/view/split_details_page.dart';
import 'package:splity_z/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.splitBloc,
  });

  final SplitBloc splitBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: splitBloc,
      child: MaterialApp.router(
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
        theme: MaterialTheme(TextTheme()).light(),
        routerConfig: GoRouter(
          // initialLocation: '/split/2',
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
        // routerDelegate: AppRouter().delegate(), // Use your router delegate
        // routeInformationParser: AppRouter().defaultRouteParser(),
        // theme: ThemeData(
        //   colorScheme: colorScheme,
        //   useMaterial3: true,
        //   appBarTheme: AppBarTheme(
        //     iconTheme: IconThemeData(color: colorScheme.onPrimary),
        //   ),
        //   fontFamily: GoogleFonts.merriweatherSans().fontFamily,
        //   // textTheme: TextTheme(
        //   //   displayLarge: const TextStyle(
        //   //     fontSize: 72,
        //   //     fontWeight: FontWeight.bold,
        //   //   ),
        //   //   // ···
        //   //   titleLarge: GoogleFonts.roboto(
        //   //     fontSize: 22,
        //   //   ),
        //   //   bodyMedium: GoogleFonts.merriweather(),
        //   //   bodyLarge: GoogleFonts.merriweather(),
        //   //   bodySmall: GoogleFonts.merriweather(),
        //   //   displaySmall: GoogleFonts.pacifico(),
        //   // ),
        // ),
      ),
    );
  }
}
