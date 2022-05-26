import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:films/components/constants.dart';
import 'package:films/data/db/database.dart';
import 'package:films/data/dtos/film_dto.dart';
import 'package:films/data/mappers/film_mapper.dart';
import 'package:films/data/repositories/interceptors/dio_error_interceptor.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/domain/models/film_card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FilmsRepository {
  FilmsRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);

    _db = Database();
  }

  final Function(String, String) onErrorHandler;

  late final Dio _dio;

  late final Database _db;

  Future<BasicModel?> loadData({required String keyword}) async {
    const String url = FilmQuery.baseUrl;
    final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
      url,
      options: Options(headers: FilmQuery.queryHeaders),
      queryParameters: <String, dynamic>{'keyword': keyword},
    );

    final BasicDTO dto =
        BasicDTO.fromJson(response.data as Map<String, dynamic>);

    final BasicModel model = dto.toDomain();
    return model;
  }

  Future<List<FilmCardModel>> getAllFilmsDB() async {
    List<FilmTableData> filmsDB = await _db.select(_db.filmTable).get();

    return filmsDB
        .map((FilmTableData filmTableData) => filmTableData.toDomain())
        .toList();
  }

  Future<void> insertFilmDB(FilmCardModel filmCardModel) async {
    await _db.into(_db.filmTable).insert(
          filmCardModel.toDatabase(),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> deleteFilmDB(int id) async {
    await (_db.delete(_db.filmTable)
          ..where((filmTable) => filmTable.id.equals(id)))
        .go();
  }

  Stream<List<FilmCardModel>> onChangedFilmsDB() {
    return (_db.select(_db.filmTable))
        .map((FilmTableData filmTableData) => filmTableData.toDomain())
        .watch();
  }
}
