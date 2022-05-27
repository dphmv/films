import 'package:cached_network_image/cached_network_image.dart';
import 'package:films/components/constants.dart';
import 'package:films/components/locals/locals.dart';
import 'package:films/components/widgets/buttons/favorite_button.dart';
import 'package:films/components/widgets/buttons/primary_button.dart';
import 'package:films/domain/models/film_card_model.dart';
import 'package:films/presentation/detail/detail_page.dart';
import 'package:flutter/material.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({
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

  factory FilmCard.fromFilmModel({
    required FilmCardModel model,
    required isFavorited,
    required onClickFavoriteButton,
    Key? key,
  }) {
    return FilmCard(
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
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
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
          Positioned(
            left: 5,
            child: _RatingChip(voteAverage!),
          ),
          Positioned(
            right: 5,
            child: FavoriteButton(
              isFavorited,
              onPressed: () {
                onClickFavoriteButton?.call();
              },
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 5,
            child: PrimaryButton(
              context.locale.buttonText,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  DetailPage.path,
                  arguments: DetailArguments(
                    id,
                    title,
                    picture!,
                    voteAverage,
                    releaseDate,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 50,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip(this.voteAverage, {Key? key}) : super(key: key);

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.star_border,
        color: Colors.white,
      ),
      label: Text(
        voteAverage.toStringAsFixed(1),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
