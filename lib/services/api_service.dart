import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  // Get all categories
  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}categories.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Get meals by category
  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('${baseUrl}filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  // Search meals
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('${baseUrl}search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to search meals');
    }
  }

  // Get meal details
  static Future<MealDetail> getMealDetail(String id) async {
    final response = await http.get(Uri.parse('${baseUrl}lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal details');
    }
  }

  // Random meal
  static Future<MealDetail> getRandomMeal() async {
    final response = await http.get(Uri.parse('${baseUrl}random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}
