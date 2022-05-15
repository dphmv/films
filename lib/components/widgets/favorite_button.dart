import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
      icon: Icon(
        !isFavorited ? Icons.favorite_border : Icons.favorite,
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}
