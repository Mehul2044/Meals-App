import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favourite;
  final Function toggleFavourite;

  const FavoritesScreen(
      {Key? key, required this.favourite, required this.toggleFavourite})
      : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void removeFavourite(String mealID) {
    final index =
        widget.favourite.indexWhere((element) => element.id == mealID);
    setState(() {
      widget.favourite.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.favourite.isEmpty
        ? Center(
            child: Text(
              "You don't have any favourites currently!!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                title: widget.favourite[index].title,
                imageUrl: widget.favourite[index].imageUrl,
                duration: widget.favourite[index].duration,
                complexity: widget.favourite[index].complexity,
                affordability: widget.favourite[index].affordability,
                id: widget.favourite[index].id,
                removeItem: (String id) {},
                toggleFavourite: (String id) {
                  setState(() {
                  widget.toggleFavourite(id);
                  });
                },
                isFavourite: (String id) {
                  return true;
                },
              );
            },
            itemCount: widget.favourite.length,
          );
  }
}
