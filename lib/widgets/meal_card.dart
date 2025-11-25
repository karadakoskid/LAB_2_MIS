import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(meal.image, height: 120, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                meal.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
