import 'package:flutter/material.dart';
import 'package:waijudi/models/category.dart';

import 'item_categories.dart';

class ListCategories extends StatelessWidget {
  final List<Category> categories;
  final Category selectedCategory;
  final Function(Category) onSelectCategory;

  const ListCategories({Key? key, required this.categories, required this.selectedCategory, required this.onSelectCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          Category category = categories.elementAt(index);
          return ItemCategories(
            category,
            category == selectedCategory,
            onSelectCategory: onSelectCategory,
          );
        },
      ),
    );
  }
}
