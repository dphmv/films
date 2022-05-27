import 'package:films/components/locals/locals.dart';
import 'package:films/components/widgets/not_found_page.dart';
import 'package:films/locale_bloc/locale_bloc.dart';
import 'package:films/locale_bloc/locale_state.dart';
import 'package:films/presentation/detail/detail_page.dart';
import 'package:films/presentation/main_page.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(const FilmApp());
}

class FilmApp extends StatelessWidget {
  const FilmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (_) => LocaleBloc(),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MAD Films',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            locale: state.locale,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              MyLocalizationsDelegate(initialLocals),
            ],
            supportedLocales: availableLocales.values,
            initialRoute: MainPage.path,
            onGenerateRoute: (RouteSettings settings) {
              if (settings.name == MainPage.path) {
                return MaterialPageRoute(
                  builder: (context) {
                    return const MainPage();
                  },
                );
              }

              if (settings.name == SettingsPage.path) {
                return MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                );
              }

              if (settings.name == DetailPage.path) {
                final DetailArguments arguments =
                    settings.arguments as DetailArguments;
                return MaterialPageRoute(
                  builder: (context) {
                    return DetailPage(
                      arguments: arguments,
                    );
                  },
                );
              }

              return MaterialPageRoute(
                builder: (_) => const NotFoundPage(),
              );
            },
          );
        },
      ),
    );
  }
}
