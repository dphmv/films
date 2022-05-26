import 'package:cached_network_image/cached_network_image.dart';
import 'package:films/components/constants.dart';
import 'package:films/components/widgets/buttons/favorite_button.dart';
import 'package:films/domain/models/film_card_model.dart';
import 'package:flutter/material.dart';

class FilmTile extends StatelessWidget {
  const FilmTile({
    required this.id,
    required this.title,
    required this.picture,
    required this.voteAverage,
    required this.releaseDate,
    this.onClickFavoriteButton,
    required this.isFavorited,
    Key? key,
  }) : super(key: key);

  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final VoidCallback? onClickFavoriteButton;
  final bool isFavorited;

  factory FilmTile.fromFilmModel({
    required FilmCardModel model,
    required isFavorited,
    required onClickFavoriteButton,
    Key? key,
  }) {
    return FilmTile(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      isFavorited: isFavorited,
      onClickFavoriteButton: onClickFavoriteButton,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                imageUrl: picture!,
                errorWidget: (_, __, ___) =>
                    Image.network(FilmQuery.missingPictureUrl),
                cacheManager: FilmPicture.pictureCache,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepOrange),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Дата выхода: $releaseDate',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        voteAverage!.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 16,
                          color: voteAverage == null
                              ? Colors.deepOrange
                              : voteAverage! < 5
                                  ? Colors.red
                                  : voteAverage! >= 8
                                      ? Colors.green
                                      : Colors.black,
                        ),
                      ),
                      FavoriteButton(
                        isFavorited,
                        onPressed: () {
                          onClickFavoriteButton?.call();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
