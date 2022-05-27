import 'package:films/components/locals/locals.dart';
import 'package:films/components/widgets/buttons/primary_button.dart';
import 'package:films/locale_bloc/locale_bloc.dart';
import 'package:films/locale_bloc/locale_event.dart';
import 'package:films/presentation/settings/bloc/settings_bloc.dart';
import 'package:films/presentation/settings/bloc/settings_event.dart';
import 'package:films/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const path = '/settings';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      lazy: false,
      create: (_) => SettingsBloc()
        ..add(
          LoadNameEvent(),
        ),
      child: const SettingsPageContent(),
    );
  }
}

class SettingsPageContent extends StatefulWidget {
  const SettingsPageContent({Key? key}) : super(key: key);

  @override
  State<SettingsPageContent> createState() => _SettingsPageContentState();
}

class _SettingsPageContentState extends State<SettingsPageContent> {
  bool isEnLocale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          context.locale.settings,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<SettingsBloc, SettingsState>(
                  buildWhen: (oldState, newState) =>
                      oldState.name != newState.name,
                  builder: (context, state) {
                    return Text(state.name ?? '');
                  }),
              PrimaryButton(context.locale.loadName, onPressed: () {
                context.read<SettingsBloc>().add(LoadNameEvent());
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PrimaryButton(context.locale.saveName, onPressed: () {
                  context
                      .read<SettingsBloc>()
                      .add(const SaveNameEvent(name: 'Данила'));
                }),
              ),
              PrimaryButton(context.locale.clearName, onPressed: () {
                context.read<SettingsBloc>().add(ClearNameEvent());
              }),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Checkbox(
                      value: isEnLocale,
                      onChanged: (val) {
                        isEnLocale = val ?? false;
                        context.read<LocaleBloc>().add(ChangeLocaleEvent(
                              isEnLocale
                                  ? availableLocales[enLocale]!
                                  : availableLocales[ruLocale]!,
                            ));
                      },
                    ),
                    Flexible(
                      child: Text(
                        context.locale.switchLanguage,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
