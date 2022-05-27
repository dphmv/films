import 'package:cached_network_image/cached_network_image.dart';
import 'package:films/components/constants.dart';
import 'package:films/components/locals/locals.dart';
import 'package:flutter/material.dart';

class DetailArguments {
  const DetailArguments(
    this.id,
    this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
  );

  final int id;
  final String title;
  final String picture;
  final double? voteAverage;
  final String? releaseDate;
}

class DetailPage extends StatelessWidget {
  const DetailPage({required this.arguments, Key? key}) : super(key: key);

  final DetailArguments arguments;

  static const path = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          arguments.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: arguments.picture,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Image.network(FilmQuery.missingPictureUrl),
                cacheManager: FilmPicture.pictureCache,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '${context.locale.releaseDate}: ${arguments.releaseDate}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          child: Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(
                          arguments.voteAverage!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
