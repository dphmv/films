import 'package:films/components/locals/locale_base.dart';

class LocaleRu implements LocaleBase {
  @override
  String get error => 'Ошибка';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get notFound => 'Не найдено';

  @override
  String get settings => 'Настройки';

  @override
  String get loadName => 'Получить имя';

  @override
  String get saveName => 'Сохранить имя';

  @override
  String get clearName => 'Очистить имя';

  @override
  String get search => 'Что будем искать?';

  @override
  String get buttonText => 'Подробнее';

  @override
  String get releaseDate => 'Дата выхода';

  @override
  String get switchLanguage => 'Сменить язык';
}
