import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'category_meals_screen.dart';
import 'meal_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  List<Category> filteredCategories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    categories = await ApiService.getCategories();
    setState(() {
      filteredCategories = categories;
      isLoading = false;
    });
  }

  void searchCategory(String query) {
    setState(() {
      filteredCategories = categories
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () async {
              final randomMeal = await ApiService.getRandomMeal();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MealDetailScreen(mealId: randomMeal.id),
                ),
              );
            },
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search categories',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: searchCategory,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return CategoryCard(
                  category: category,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CategoryMealsScreen(categoryName: category.name),
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
