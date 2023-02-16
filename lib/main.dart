import 'package:flutter/material.dart';
import 'package:meals_app/data_files/dummy_data.dart';
import 'package:meals_app/screens/categories_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> availableMeals = dummyMeals;
  List<Meal> favouriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      availableMeals = dummyMeals.where((meal) {
        if (filters["gluten"] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (filters["lactose"] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (filters["vegan"] as bool && !meal.isVegan) {
          return false;
        }
        if (filters["vegetarian"] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealID) {
    final existingIndex =
        favouriteMeals.indexWhere((element) => element.id == mealID);
    setState(() {
      if (existingIndex >= 0) {
        favouriteMeals.removeAt(existingIndex);
      } else {
        Meal obj = dummyMeals.firstWhere((element) => element.id == mealID);
        favouriteMeals.add(obj);
      }
    });
  }

  bool isFavourite(String mealID) {
    return favouriteMeals.any((element) => element.id == mealID);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meals",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(
          favouriteMeals: favouriteMeals, toggleFavourite: toggleFavorite),
      routes: {
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              availableMeals: availableMeals,
              toggleFavourite: toggleFavorite,
              isFavourite: isFavourite,
            ),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(isFavourite: isFavourite),
        FilterScreen.routeName: (context) =>
            FilterScreen(setFilters: setFilters, currentFilter: filters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   if (settings.name == "/meal-detail"){
      //     return something;
      //   }else if (settings.name == "/something-else"){
      //     return MaterialPageRoute(builder: (context) => XScreen());
      //   }
      //   return MaterialPageRoute(builder: (context) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => TabsScreen(
                favouriteMeals: favouriteMeals,
                toggleFavourite: toggleFavorite));
      },
    );
  }
}
