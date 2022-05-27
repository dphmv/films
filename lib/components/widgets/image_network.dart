import 'package:films/components/constants.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork(this.pictureUrl, {this.fit = BoxFit.cover, Key? key})
      : super(key: key);

  final String pictureUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pictureUrl,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      fit: fit,
    );
  }
}

class Missing extends StatelessWidget {
  const Missing({Key? key}) : super(key: key);

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

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

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
