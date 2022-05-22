import 'package:dio/dio.dart';
import 'package:films/components/constants.dart';
import 'package:films/components/dialogs/error_dialog.dart';
import 'package:films/data/dtos/film_dto.dart';
import 'package:films/data/mappers/film_mapper.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FilmsRepository {
  static final Dio _dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );

  static Future<BasicModel?> loadData(
    BuildContext context, {
    required int ratingFrom,
    required String keyword,
  }) async {
    try {
      const String url = FilmQuery.baseUrl;
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        options: Options(headers: FilmQuery.queryHeaders),
        queryParameters: <String, dynamic>{
          'ratingFrom': ratingFrom,
          'keyword': keyword,
        },
      );

      final BasicDTO dto =
          BasicDTO.fromJson(response.data as Map<String, dynamic>);

      final BasicModel model = dto.toDomain();
      return model;
    } on DioError catch (error) {
      final statusCode = error.response?.statusCode;
      showErrorDialog(context, error: statusCode?.toString() ?? '');
      return null;
    }
  }
}
