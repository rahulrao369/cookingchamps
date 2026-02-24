import 'package:flutter/material.dart';
import 'recipe_model.dart';
import 'ai_recipe_service.dart';

class AiRecipeController {
  final ValueNotifier<List<RecipeModel>> recipes =
  ValueNotifier<List<RecipeModel>>([]);

  final int totalRecipes = 5;

  final AiRecipeService _service = AiRecipeService();

  Future<void> generateRandomRecipesProgressively() async {
    recipes.value = [];

    final dishType = _pickRandom(_service.dishTypes);
    final cookingMethod = _pickRandom(_service.cookingMethods);
    final ageGroup = _pickRandom(_service.ageGroups);
    final difficulty = _pickRandom(_service.difficulties);

    for (int i = 1; i <= totalRecipes; i++) {
      try {
        final recipe = await _service.generateSingleRandomRecipe(
          index: i,
          dishType: dishType,
          cookingMethod: cookingMethod,
          ageGroup: ageGroup,
          difficulty: difficulty,
        );

        recipes.value = [...recipes.value, recipe];
      } catch (e) {
        debugPrint("Failed recipe $i: $e");
      }
    }
  }

  T _pickRandom<T>(List<T> list) {
    list.shuffle();
    return list.first;
  }

  void dispose() {
    recipes.dispose();
  }
}
