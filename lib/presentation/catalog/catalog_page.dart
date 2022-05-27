import 'package:collection/collection.dart';
import 'package:films/components/delayed_action.dart';
import 'package:films/components/locals/locals.dart';
import 'package:films/components/widgets/image_network.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/presentation/catalog/bloc/catalog_bloc.dart';
import 'package:films/presentation/catalog/bloc/catalog_event.dart';
import 'package:films/presentation/catalog/bloc/catalog_state.dart';
import 'package:films/presentation/catalog/film_card.dart';
import 'package:films/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool isSearching = false;

  final TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    context.read<CatalogBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: CatalogPage.globalKey,
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
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: context.locale.search,
                  hintStyle: const TextStyle(
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
          return RefreshIndicator(
            onRefresh: _refresh,
            child: FutureBuilder<BasicModel?>(
              future: state.data,
              builder: (BuildContext context, AsyncSnapshot<BasicModel?> data) {
                return data.connectionState != ConnectionState.done
                    ? const Center(child: CircularProgressIndicator())
                    : data.hasData
                        ? data.data?.film?.isNotEmpty == true
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child: GridView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool isFavourite = false;
                                    if (state.favouritesFilms?.isNotEmpty ==
                                        true) {
                                      var filmsFavourite = state.favouritesFilms
                                          ?.firstWhereOrNull((element) =>
                                              element.id ==
                                              data.data?.film?[index].id);
                                      if (filmsFavourite != null) {
                                        isFavourite = true;
                                      }
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: FilmCard.fromFilmModel(
                                        model: data.data!.film![index],
                                        isFavorited: isFavourite,
                                        onClickFavoriteButton: () {
                                          isFavourite = !isFavourite;
                                          context.read<CatalogBloc>().add(
                                                ChangedFavourites(
                                                  model:
                                                      data.data?.film?[index],
                                                ),
                                              );
                                        },
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
                            : const Empty()
                        : const Missing();
              },
            ),
          );
        },
      ),
    );
  }

  void _onSearchFieldTextChanged(String query) {
    DelayedAction.run(() {
      context.read<CatalogBloc>().add(SearchChangedEvent(search: query));
    });
  }

  Future<void> _refresh() async {
    context.read<CatalogBloc>().add(LoadDataEvent());
  }
}
