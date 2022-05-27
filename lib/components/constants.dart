import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FilmQuery {
  static const String baseUrl =
      'https://kinopoiskapiunofficial.tech/api/v2.2/films';

  static const String missingPictureUrl =
      'https://prosmarttv.ru/wp-content/uploads/2017/05/profilaktika.jpg';
  static const String emptyPictureUrl =
      'https://risovach.ru/upload/2015/11/mem/lenivec_98364492_orig_.jpg';

  static const String initialWord = 'gentlemen';

  static const String apiKey = '3a82711e-cd3e-4507-8959-bee16d51a6c4';
  static const String contentType = 'application/json';
  static Map<String, dynamic> queryHeaders = <String, dynamic>{
    'X-API-KEY': FilmQuery.apiKey,
    'Content-Type': FilmQuery.contentType,
  };
}

class FilmPicture {
  static CacheManager pictureCache =
      CacheManager(Config('filmPicture', stalePeriod: const Duration(days: 7)));
}

class UserQuery {
  static const String keyName = 'name';
}
