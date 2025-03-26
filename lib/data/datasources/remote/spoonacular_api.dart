import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/recipe_model.dart';

class SpoonacularApi {
  final String baseUrl = "api.spoonacular.com";

  Future<List<RecipeModel>> getRecipes(String query, String diet) async {
    final uri = Uri.https(baseUrl, "/recipes/complexSearch", {
      "query": query,
      "diet": diet,
      "apiKey": "6c105531c62b4d6ca73c9555b1851723",
      "addNutrition": "true",
      "number": "10",
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => RecipeModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load recipes");
    }
  }

  // Get Random Recipes (for Top Picks)
  Future<List<RecipeModel>> getRandomRecipes() async {
    final uri = Uri.https(baseUrl, "/recipes/random", {
      "apiKey": "6c105531c62b4d6ca73c9555b1851723",
      "number": "5",
      "addNutrition": "true",
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['recipes'] as List)
          .map((json) => RecipeModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load random recipes");
    }
  }

  // Get Recipe Information
  Future<RecipeModel> getRecipeDetails(int id) async {
    final uri = Uri.https(baseUrl, "/recipes/$id/information", {
      "apiKey": "6c105531c62b4d6ca73c9555b1851723",
      "includeNutrition": "true",
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RecipeModel.fromJson(data);
    } else {
      throw Exception("Failed to load recipe details");
    }
  }

  // Get Analyzed Instructions
  Future<List<String>> getAnalyzedInstructions(int id) async {
    final uri = Uri.https(baseUrl, "/recipes/$id/analyzedInstructions", {
      "apiKey": "6c105531c62b4d6ca73c9555b1851723",
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data[0]['steps'] as List)
          .map((step) => step['step'] as String)
          .toList();
    } else {
      return [];
    }
  }
}
