import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meal_mind/presentation/screens/recip_details_screen.dart';
import '../providers/recipe_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(recipeProvider.notifier).fetchRandomRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Finder")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel for Top Picks
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Top Picks",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            recipes.when(
              data:
                  (recipes) => CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items:
                        recipes
                            .map(
                              (recipe) => GestureDetector(
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => RecipeDetailScreen(
                                              recipeId: recipe.id,
                                            ),
                                      ),
                                    ),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      recipe.image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: Colors.black54,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          recipe.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
              loading:
                  () => const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              error:
                  (error, _) => SizedBox(
                    height: 200,
                    child: Center(child: Text("Error: $error")),
                  ),
            ),
            // Search Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  ref
                      .read(recipeProvider.notifier)
                      .fetchRecipes(value, "vegetarian");
                },
                decoration: const InputDecoration(
                  hintText: "Search recipes...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // Grid of Recipes
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Explore Recipes",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            recipes.when(
              data:
                  (recipes) => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        RecipeDetailScreen(recipeId: recipe.id),
                              ),
                            ),
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            title: Text(recipe.title),
                            subtitle: Text(
                              "Calories: ${recipe.nutrition['calories'] ?? 'N/A'}",
                            ),
                          ),
                          child: Image.network(recipe.image, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text("Error: $error")),
            ),
          ],
        ),
      ),
    );
  }
}
