import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton(this.isFavorited, {required this.onPressed, Key? key})
      : super(key: key);

  final bool isFavorited;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}
