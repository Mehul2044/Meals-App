import 'package:flutter/material.dart';

class FavouriteToggle extends StatelessWidget {
  final String id;
  final bool isFavourite;
  final Function toggleFavourite;

  const FavouriteToggle(
      {Key? key,
      required this.isFavourite,
      required this.toggleFavourite,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        toggleFavourite(id);
      },
      icon: Icon(Icons.star,
          color: isFavourite
              ? Theme.of(context).colorScheme.primary
              : Colors.black12),
    );
  }
}
