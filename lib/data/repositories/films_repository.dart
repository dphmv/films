import 'package:dio/dio.dart';
import 'package:films/components/constants.dart';
import 'package:films/data/dtos/film_dto.dart';
import 'package:films/data/mappers/film_mapper.dart';
import 'package:films/data/repositories/interceptors/dio_error_interceptor.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FilmsRepository {
  final Function(String, String) onErrorHandler;

  late final Dio _dio;

  FilmsRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);
  }

  Future<BasicModel?> loadData({
    required String keyword,
  }) async {
    const String url = FilmQuery.baseUrl;
    final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
      url,
      options: Options(headers: FilmQuery.queryHeaders),
      queryParameters: <String, dynamic>{
        'keyword': keyword,
      },
    );

    final BasicDTO dto =
        BasicDTO.fromJson(response.data as Map<String, dynamic>);

    final BasicModel model = dto.toDomain();
    return model;
  }
}
