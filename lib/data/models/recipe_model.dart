// recipe_model.dart
import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.nutrition,
    super.summary,
    super.instructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      nutrition: json['nutrition'] ?? {},
      summary: json['summary'] ?? '',
      instructions:
          json['analyzedInstructions'] != null
              ? (json['analyzedInstructions'][0]['steps'] as List)
                  .map((step) => step['step'] as String)
                  .toList()
              : [],
    );
  }
}
