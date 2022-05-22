import 'package:films/components/constants.dart';
import 'package:films/data/repositories/films_repository.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/presentation/home/film_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<BasicModel?>? dataLoadingState;

  @override
  void didChangeDependencies() {
    dataLoadingState ??= FilmsRepository.loadData(context,
        ratingFrom: FilmQuery.ratingFrom, keyword: FilmQuery.initialWord);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'MAD',
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              ),
              TextSpan(text: ' Films'),
            ],
          ),
        ),
      ),
      body: FutureBuilder<BasicModel?>(
        future: dataLoadingState,
        builder: (BuildContext context, AsyncSnapshot<BasicModel?> data) {
          return data.connectionState != ConnectionState.done
              ? const Center(child: CircularProgressIndicator())
              : data.hasData
                  ? data.data?.film?.isNotEmpty == true
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: FilmTile.fromFilmModel(
                                  model: data.data!.film![index],
                                  key: ValueKey<int>(
                                    data.data?.film?[index].id ?? -1,
                                  ),
                                ),
                              );
                            },
                            itemCount: data.data?.film?.length ?? 0,
                          ),
                        )
                      : const _Empty()
                  : const _Missing();
        },
      ),
    );
  }
}

class _Missing extends StatelessWidget {
  const _Missing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      FilmQuery.missingPictureUrl,
      fit: BoxFit.cover,
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      FilmQuery.emptyPictureUrl,
      fit: BoxFit.cover,
    );
  }
}
