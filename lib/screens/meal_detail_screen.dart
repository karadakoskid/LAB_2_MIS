import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;

  MealDetailScreen({required this.mealId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MealDetail>(
      future: ApiService.getMealDetail(mealId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error loading meal')));
        } else {
          final meal = snapshot.data!;
          return Scaffold(
            appBar: AppBar(title: Text(meal.name)),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(meal.image),
                  SizedBox(height: 12),
                  Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(meal.instructions),
                  SizedBox(height: 12),
                  Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...meal.ingredients.map((e) => Text(e)).toList(),
                  SizedBox(height: 12),
                  if (meal.youtubeUrl != null && meal.youtubeUrl!.isNotEmpty)
                    ElevatedButton(
                      onPressed: () async {
                        if (await canLaunch(meal.youtubeUrl!)) {
                          await launch(meal.youtubeUrl!);
                        }
                      },
                      child: Text('Watch on YouTube'),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
