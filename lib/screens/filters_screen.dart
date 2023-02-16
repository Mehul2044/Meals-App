import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  final Map<String, bool> currentFilter;
  final Function setFilters;
  static const routeName = "/filters";

  const FilterScreen(
      {Key? key, required this.setFilters, required this.currentFilter})
      : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  void changeFilter() {
    final selectedFilters = {
      "gluten": glutenFree,
      "lactose": lactoseFree,
      "vegan": vegan,
      "vegetarian": vegetarian,
    };
    widget.setFilters(selectedFilters);
  }

  @override
  void initState() {
    glutenFree = widget.currentFilter["gluten"] as bool;
    lactoseFree = widget.currentFilter["lactose"] as bool;
    vegan = widget.currentFilter["vegan"] as bool;
    vegetarian = widget.currentFilter["vegetarian"] as bool;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile.adaptive(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your Meal Selection",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile("Gluten-free",
                    "Only include Gluten-free meals.", glutenFree, (p0) {
                  setState(() {
                    glutenFree = p0;
                    changeFilter();
                  });
                }),
                buildSwitchListTile("Lactose-free",
                    "Only include Lactose-free meals.", lactoseFree, (p0) {
                  setState(() {
                    lactoseFree = p0;
                    changeFilter();
                  });
                }),
                buildSwitchListTile(
                    "Vegetarian", "Only include Vegetarian meals.", vegetarian,
                    (p0) {
                  setState(() {
                    vegetarian = p0;
                    changeFilter();
                  });
                }),
                buildSwitchListTile("Vegan", "Only include Vegan meals.", vegan,
                    (p0) {
                  setState(() {
                    vegan = p0;
                    changeFilter();
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}