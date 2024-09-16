import 'package:flutter/cupertino.dart';

Widget buildCategoriesSection(List<dynamic> categories) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Image.network(
                    category['icon'],
                    height: 50,
                    width: 50,
                  ),
                  Text(category['label']),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
