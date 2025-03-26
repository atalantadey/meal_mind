// recipe_repository_impl.dart
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/remote/spoonacular_api.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final SpoonacularApi api;

  RecipeRepositoryImpl(this.api);

  @override
  Future<List<Recipe>> getRecipes(String query, String diet) async {
    return await api.getRecipes(query, diet);
  }

  @override
  Future<List<Recipe>> getRandomRecipes() async {
    return await api.getRandomRecipes();
  }

  @override
  Future<Recipe> getRecipeDetails(int id) async {
    return await api.getRecipeDetails(id);
  }
}
