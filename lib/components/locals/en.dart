import 'package:films/components/locals/locale_base.dart';

class LocaleEn implements LocaleBase {
  @override
  String get error => 'Error';

  @override
  String get unknown => 'Unknown';

  @override
  String get notFound => 'Not found';

  @override
  String get settings => 'Settings';

  @override
  String get loadName => 'Load name';

  @override
  String get saveName => 'Save name';

  @override
  String get clearName => 'Clear name';

  @override
  String get search => 'What are you looking for?';

  @override
  String get buttonText => 'More';

  @override
  String get releaseDate => 'Release date';

  @override
  String get switchLanguage => 'Switch language';
}
