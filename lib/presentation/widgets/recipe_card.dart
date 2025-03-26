// recipe_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(recipe.image, width: 50, fit: BoxFit.cover),
        title: Text(recipe.title),
        subtitle: Text("Calories: ${recipe.nutrition['calories'] ?? 'N/A'}"),
      ),
    );
  }
}
