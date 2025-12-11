import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() async {
    final favorite = await FavoritesService.isFavorite(widget.meal.id);
    setState(() {
      isFavorite = favorite;
    });
  }

  void toggleFavorite() async {
    if (isFavorite) {
      await FavoritesService.removeFavorite(widget.meal.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Рецептот е отстранет од омилените')),
      );
    } else {
      await FavoritesService.addFavorite(widget.meal);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Рецептот е додаден во омилените')),
      );
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: Stack(
          children: [
            Column(
              children: [
                Image.network(
                  widget.meal.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.meal.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: toggleFavorite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
