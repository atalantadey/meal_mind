import 'package:get_it/get_it.dart';
import 'package:meal_mind/data/repositories/recipe_repository.dart';
import 'package:meal_mind/domain/usecases/get_recipe.dart';
import 'package:meal_mind/domain/usecases/get_recipe_details.dart';
import '../data/datasources/remote/spoonacular_api.dart';
import '../domain/repositories/recipe_repository.dart';


final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => SpoonacularApi());
  sl.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetRecipes(sl()));
  sl.registerLazySingleton(() => GetRecipeDetails(sl()));
}
