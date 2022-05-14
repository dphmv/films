import 'package:films/components/widgets/not_found_page.dart';
import 'package:films/presentation/main_page.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FilmApp());

class FilmApp extends StatelessWidget {
  const FilmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAD Films',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: MainPage.path,
      onGenerateRoute: (settings) {
        if (settings.name == MainPage.path) {
          return MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          );
        }

        if (settings.name == SettingsPage.path) {
          final SettingsArguments arguments =
              settings.arguments as SettingsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return SettingsPage(
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
  }
}
