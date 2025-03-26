import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/recipe_provider.dart';

class RecipeDetailScreen extends ConsumerWidget {
  final int recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref
        .watch(recipeProvider.notifier)
        .fetchRecipeDetails(recipeId);

    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Details")),
      body: FutureBuilder(
        future: recipeAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final recipe = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  recipe.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Calories: ${recipe.nutrition['calories'] ?? 'N/A'}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Summary",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        recipe.summary.replaceAll(RegExp(r'<[^>]+>'), ''),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Instructions",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...recipe.instructions.map(
                        (step) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "• $step",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
