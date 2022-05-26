import 'package:films/components/widgets/buttons/primary_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Настройки',
          style: TextStyle(
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
              PrimaryButton('Получить имя', onPressed: () {
                context.read<SettingsBloc>().add(LoadNameEvent());
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PrimaryButton('Сохранить имя', onPressed: () {
                  context
                      .read<SettingsBloc>()
                      .add(const SaveNameEvent(name: 'Данила'));
                }),
              ),
              PrimaryButton('Очистить имя', onPressed: () {
                context.read<SettingsBloc>().add(ClearNameEvent());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
