import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final Function isFavourite;
  final Function toggleFavourite;
  final List<Meal> availableMeals;
  static const routeName = "/category-meals";

  const CategoryMealsScreen({Key? key,
    required this.availableMeals,
    required this.toggleFavourite,
    required this.isFavourite})
      : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal> displayedMeals = [];
  bool loadedInitData = false;
  
  @override
  Widget build(BuildContext context) {
    if (!loadedInitData) {
      final routeArgs =
      ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String, String>;
      categoryTitle = routeArgs["title"];
      displayedMeals = widget.availableMeals.where(
            (element) {
          return element.categories.contains(routeArgs["id"]);
        },
      ).toList();
      loadedInitData = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            id: displayedMeals[index].id,
            removeItem: (mealID) {
              setState(() {
                displayedMeals.removeWhere((element) => element.id == mealID);
              });
            },
            toggleFavourite: widget.toggleFavourite,
            isFavourite: widget.isFavourite,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}