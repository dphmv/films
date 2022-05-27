import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

class ChangeLocaleEvent extends LocaleEvent {
  const ChangeLocaleEvent(this.locale);

  final Locale locale;

  @override
  List<Object> get props => [locale];
}
