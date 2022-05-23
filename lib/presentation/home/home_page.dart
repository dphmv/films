import 'package:films/components/widgets/image_network.dart';
import 'package:films/domain/models/basic_model.dart';
import 'package:films/presentation/home/bloc/home_bloc.dart';
import 'package:films/presentation/home/bloc/home_event.dart';
import 'package:films/presentation/home/bloc/home_state.dart';
import 'package:films/presentation/home/film_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
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
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (oldState, newState) => oldState.data != newState.data,
        builder: (context, state) {
          return FutureBuilder<BasicModel?>(
            future: state.data,
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
                          : const Empty()
                      : const Missing();
            },
          );
        },
      ),
    );
  }
}
