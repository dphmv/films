import 'package:films/components/constants.dart';
import 'package:films/presentation/settings/bloc/settings_event.dart';
import 'package:films/presentation/settings/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadNameEvent>(_onLoadName);
    on<SaveNameEvent>(_onSaveName);
    on<ClearNameEvent>(_onClearName);
  }

  void _onLoadName(LoadNameEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString(UserQuery.keyName);
    emit(state.copyWith(name: name));
  }

  void _onSaveName(SaveNameEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(UserQuery.keyName, event.name);
    emit(state.copyWith(name: event.name));
  }

  void _onClearName(ClearNameEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(UserQuery.keyName);
    emit(state.copyWith(name: ''));
  }
}
