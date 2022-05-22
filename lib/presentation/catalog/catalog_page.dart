import 'package:films/components/constants.dart';
import 'package:films/components/delayed_action.dart';
import 'package:films/presentation/catalog/film_card.dart';
import 'package:films/data/repositories/films_repository.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final TextEditingController controller = TextEditingController();

  bool isSearching = false;

  Future<BasicModel?>? dataLoadingState;

  @override
  void didChangeDependencies() {
    dataLoadingState ??= FilmsRepository.loadData(
      context,
      ratingFrom: FilmQuery.ratingFrom,
      keyword: FilmQuery.initialWord,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: !isSearching
            ? RichText(
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
              )
            : TextField(
                controller: controller,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Что будем искать?',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: _onSearchFieldTextChanged,
              ),
        actions: <Widget>[
          !isSearching
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
              : CloseButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                ),
          !isSearching
              ? IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/settings',
                      arguments:
                          const SettingsArguments('dph.develop@gmail.com'),
                    );
                  },
                )
              : PopupMenuButton(
                  icon: const Icon(Icons.filter_alt),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      child: Text('Больше 8'),
                      value: 8,
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 8) {
                      _selectedRate(FilmQuery.cunningRating);
                    }
                  },
                ),
        ],
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
                          child: GridView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: FilmCard.fromFilmModel(
                                  model: data.data!.film![index],
                                  key: ValueKey<int>(
                                    data.data?.film?[index].id ?? -1,
                                  ),
                                ),
                              );
                            },
                            itemCount: data.data?.film?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                            ),
                          ),
                        )
                      : const _Empty()
                  : const _Missing();
        },
      ),
    );
  }

  void _onSearchFieldTextChanged(String query) {
    DelayedAction.run(() {
      dataLoadingState = FilmsRepository.loadData(
        context,
        ratingFrom: FilmQuery.ratingFrom,
        keyword: query.isNotEmpty ? query : FilmQuery.initialWord,
      );
      setState(() {});
    });
  }

  void _selectedRate(int rate) {
    DelayedAction.run(() {
      dataLoadingState = FilmsRepository.loadData(
        context,
        ratingFrom: rate,
        keyword: FilmQuery.initialWord,
      );
      setState(() {});
    });
  }
}

class _Missing extends StatelessWidget {
  const _Missing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        FilmQuery.missingPictureUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        FilmQuery.emptyPictureUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
