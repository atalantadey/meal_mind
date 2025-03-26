import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_mind/domain/repositories/recipe_repository.dart';
import 'package:meal_mind/domain/usecases/get_recipe.dart';
import 'package:meal_mind/domain/usecases/get_recipe_details.dart';
import '../../di/dependency_injection.dart';
import '../../domain/entities/recipe.dart';


final recipeProvider =
    StateNotifierProvider<RecipeNotifier, AsyncValue<List<Recipe>>>((ref) {
      return RecipeNotifier(sl<GetRecipes>(), sl<GetRecipeDetails>());
    });

class RecipeNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  final GetRecipes getRecipes;
  final GetRecipeDetails getRecipeDetails;

  RecipeNotifier(this.getRecipes, this.getRecipeDetails)
    : super(const AsyncValue.loading());

  Future<void> fetchRecipes(String query, String diet) async {
    state = const AsyncValue.loading();
    try {
      final recipes = await getRecipes(query, diet);
      state = AsyncValue.data(recipes);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> fetchRandomRecipes() async {
    state = const AsyncValue.loading();
    try {
      final recipes = await sl<RecipeRepository>().getRandomRecipes();
      state = AsyncValue.data(recipes);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<Recipe> fetchRecipeDetails(int id) async {
    return await getRecipeDetails(id);
  }
}
