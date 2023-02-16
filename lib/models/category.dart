import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final Color backgroundColor;

  const Category(
      {required this.id,
      required this.name,
      this.backgroundColor = Colors.orange});
}
