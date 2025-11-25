import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';

import 'meal_detail_screen.dart';
// import 'meal_card.dart';
class CategoryMealsScreen extends StatefulWidget {
  final String categoryName;

  CategoryMealsScreen({required this.categoryName});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  void fetchMeals() async {
    meals = await ApiService.getMealsByCategory(widget.categoryName);
    setState(() {
      filteredMeals = meals;
      isLoading = false;
    });
  }

  void searchMeal(String query) async {
    if (query.isEmpty) {
      setState(() => filteredMeals = meals);
      return;
    }
    filteredMeals = await ApiService.searchMeals(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search meals',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: searchMeal,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredMeals.length,
              itemBuilder: (context, index) {
                final meal = filteredMeals[index];
                return MealCard(
                  meal: meal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailScreen(mealId: meal.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
