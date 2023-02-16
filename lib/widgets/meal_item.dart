import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../screens/meal_detail_screen.dart';
import 'favourite_toggle.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;
  final Function toggleFavourite;
  final Function isFavourite;

  const MealItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
    required this.removeItem,
    required this.toggleFavourite,
    required this.isFavourite,
  }) : super(key: key);

  String get complexityText {
    if (complexity == Complexity.simple) {
      return "Simple";
    } else if (complexity == Complexity.challenging) {
      return "Challenging";
    } else {
      return "Hard";
    }
  }

  String get affordabilityText {
    if (affordability == Affordability.affordable) {
      return "Affordable";
    } else if (affordability == Affordability.pricey) {
      return "Pricey";
    } else {
      return "Luxurious";
    }
  }

  void selectMeal(BuildContext context) {
    if (!isFavourite(id)) {
      Navigator.of(context)
          .pushNamed(MealDetailScreen.routeName, arguments: id)
          .then((value) {
        if (value != null) {
          removeItem(value);
        }
      });
    } else {
      Navigator.of(context)
          .pushNamed(MealDetailScreen.routeName, arguments: id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("$duration min"),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(complexityText),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(affordabilityText),
                    ],
                  ),
                  Column(
                    children: [
                      FavouriteToggle(
                        isFavourite: isFavourite(id),
                        toggleFavourite: toggleFavourite,
                        id: id,
                      ),
                      const Text("Favourite"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
