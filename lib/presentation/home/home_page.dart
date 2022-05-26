import 'package:collection/collection.dart';
import 'package:films/components/widgets/image_network.dart';
import 'package:films/data/repositories/films_repository.dart';
import 'package:films/domain/models/film_card_model.dart';
import 'package:films/presentation/catalog/bloc/catalog_bloc.dart';
import 'package:films/presentation/catalog/bloc/catalog_event.dart';
import 'package:films/presentation/catalog/bloc/catalog_state.dart';
import 'package:films/presentation/home/film_tile.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<FilmCardModel>> film;

  @override
  void didChangeDependencies() {
    film = context.read<FilmsRepository>().getAllFilmsDB();
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsPage.path,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CatalogBloc, CatalogState>(
        buildWhen: (oldState, newState) =>
            oldState.data != newState.data ||
            oldState.favouritesFilms != newState.favouritesFilms,
        builder: (context, state) {
          return FutureBuilder<List<FilmCardModel>>(
            future: film,
            builder: (BuildContext context,
                AsyncSnapshot<List<FilmCardModel>> data) {
              return data.connectionState != ConnectionState.done
                  ? const Center(child: CircularProgressIndicator())
                  : data.hasData
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              bool isFavourite = false;
                              if (state.favouritesFilms?.isNotEmpty == true) {
                                var filmsFavourite = state.favouritesFilms
                                    ?.firstWhereOrNull((element) =>
                                        element.id == data.data?[index].id);
                                if (filmsFavourite != null) {
                                  isFavourite = true;
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: FilmTile.fromFilmModel(
                                  model: data.data![index],
                                  isFavorited: isFavourite,
                                  onClickFavoriteButton: () {
                                    isFavourite = !isFavourite;
                                    context.read<CatalogBloc>().add(
                                          ChangedFavourites(
                                            model: data.data?[index],
                                          ),
                                        );
                                  },
                                  key: ValueKey<int>(
                                    data.data?[index].id ?? -1,
                                  ),
                                ),
                              );
                            },
                            itemCount: data.data?.length ?? 0,
                          ),
                        )
                      : const Missing();
            },
          );
        },
      ),
    );
  }
}
