import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';

// class TabsScreen extends StatelessWidget {
//   const TabsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       initialIndex: 0, // by default it is zero only, so it is redundant
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Meals"),
//           bottom:  const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: "Categories",
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: "Favorites",
//               ),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             CategoriesScreen(),
//             FavoritesScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  final Function toggleFavourite;

  const TabsScreen(
      {Key? key, required this.favouriteMeals, required this.toggleFavourite})
      : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _pages;

  int _selectPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        "page": const CategoriesScreen(),
        "title": "Categories",
      },
      {
        "page": FavoritesScreen(
          favourite: widget.favouriteMeals, toggleFavourite: widget.toggleFavourite,
        ),
        "title": "Your Favorites",
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages![_selectPageIndex]["title"] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages![_selectPageIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.fixed,
        // it is the default value
        items: const [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}