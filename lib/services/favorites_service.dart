import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_meals';

  static Future<List<Meal>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

    return favoritesJson.map((json) {
      final Map<String, dynamic> mealMap = jsonDecode(json);
      return Meal.fromJson(mealMap);
    }).toList();
  }

  static Future<void> addFavorite(Meal meal) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    // Check if meal is not already in favorites
    if (!favorites.any((favMeal) => favMeal.id == meal.id)) {
      favorites.add(meal);
      final favoritesJson = favorites.map((meal) {
        return jsonEncode({
          'idMeal': meal.id,
          'strMeal': meal.name,
          'strMealThumb': meal.image,
        });
      }).toList();

      await prefs.setStringList(_favoritesKey, favoritesJson);
    }
  }

  static Future<void> removeFavorite(String mealId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    favorites.removeWhere((meal) => meal.id == mealId);
    final favoritesJson = favorites.map((meal) {
      return jsonEncode({
        'idMeal': meal.id,
        'strMeal': meal.name,
        'strMealThumb': meal.image,
      });
    }).toList();

    await prefs.setStringList(_favoritesKey, favoritesJson);
  }

  static Future<bool> isFavorite(String mealId) async {
    final favorites = await getFavorites();
    return favorites.any((meal) => meal.id == mealId);
  }
}
