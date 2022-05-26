import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({this.name});

  final String? name;

  SettingsState copyWith({
    String? name,
  }) =>
      SettingsState(name: name ?? this.name);

  @override
  List<Object> get props => [name ?? ''];
}
