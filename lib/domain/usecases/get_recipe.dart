// get_recipes.dart
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipes {
  final RecipeRepository repository;

  GetRecipes(this.repository);

  Future<List<Recipe>> call(String query, String diet) async {
    return await repository.getRecipes(query, diet);
  }
}
