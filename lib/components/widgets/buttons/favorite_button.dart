import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorited = !_isFavorited;
        });
      },
      icon: Icon(
        _isFavorited ? Icons.favorite : Icons.favorite_border,
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}
