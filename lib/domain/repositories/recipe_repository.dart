// recipe_repository.dart
import 'package:meal_mind/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes(String query, String diet);
  Future<List<Recipe>> getRandomRecipes();
  Future<Recipe> getRecipeDetails(int id);
}
