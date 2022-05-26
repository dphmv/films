import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadNameEvent extends SettingsEvent {}

class SaveNameEvent extends SettingsEvent {
  const SaveNameEvent({required this.name});

  final String name;

  @override
  List<Object> get props => [];
}

class ClearNameEvent extends SettingsEvent {}
