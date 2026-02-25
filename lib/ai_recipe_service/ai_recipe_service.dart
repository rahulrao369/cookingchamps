import 'dart:convert';
import 'dart:io';
import 'package:cooking_champs/ai_recipe_service/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class AiRecipeService {
  // 🔐 OpenAI API Key (DEV ONLY — do NOT ship to production)
  const String _openAiApiKey = "";

  // 🌐 OpenAI Chat Completions Endpoint
  static const String _chatEndpoint =
      "https://api.openai.com/v1/chat/completions";

  // 🖼️ OpenAI Images Endpoint
  static const String _imageEndpoint =
      "https://api.openai.com/v1/images/generations";

  List<String> dishTypes = [
    "Hot",
    "Cold",
  ];

  List<String> cookingMethods = [
    "No Heat",
    "Oven (Adult Supervision)",
    "Gas (Adult Only)",
  ];

  List<String> ageGroups = [
    "6–8",
    "9–10",
    "11–12",
  ];

  List<String> difficulties = [
    "Easy",
    "With Parent",
  ];


  /// 🖼️ Generate recipe from image
  Future<RecipeModel> generateRecipeFromImage(
      File image,
      String notes, {
        String dishType = "Hot",
        String cookingMethod = "Gas (Adult Only)",
        String ageGroup = "9–10",
        String difficulty = "With Parent",
      }) async {
    try {
      final bytes = await image.readAsBytes();
      final base64 = base64Encode(bytes);

      final body = {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
            "You are a professional chef and child-safe cooking instructor."
          },
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": """
Identify the dish from the image and generate ONE complete recipe.

Safety Constraints:
• Dish Type: $dishType
• Cooking Method: $cookingMethod
• Age Group: $ageGroup
• Difficulty: $difficulty

STRICT OUTPUT RULES:
• Valid JSON only
• No markdown
• No explanations
• Quotes required

FORMAT (MANDATORY):

{
  "name": "Dish Name",
  "description": "Short, kid-friendly description",
  "cookingTime": "Exact total time required (e.g. 10 minutes, 2–4 hours chilling, 30 minutes total)",
  "ingredients": ["ingredient1", "ingredient2"],
  "steps": ["Step 1", "Step 2"]
}

RULES FOR cookingTime:
• MUST be a string
• MUST NOT be empty
• If no heat is used, include prep or chilling time
• NEVER use symbols like — or null

Notes: $notes
"""
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "data:image/jpeg;base64,$base64"
                }
              }
            ]
          }
        ],
        "response_format": {"type": "json_object"},
        "temperature": 0.4
      };

      final response = await http.post(
        Uri.parse(_chatEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_openAiApiKey",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception("OpenAI error: ${response.body}");
      }

      final decoded = jsonDecode(response.body);
      final recipeJson =
      jsonDecode(decoded["choices"][0]["message"]["content"]);

      final recipe = RecipeModel.fromJson(recipeJson);

      // Attach AI-generated image
      return await attachAiImage(recipe);
    } catch (e) {
      log("Recipe generation from image failed: $e");
      rethrow;
    }
  }

  final Set<String> _usedRecipeSignatures = {};

  String buildRecipeSignature(RecipeModel r) {
    final mainIngredients = r.ingredients.take(2).join(",");
    return "${r.name.toLowerCase()}|$mainIngredients";
  }

  Future<RecipeModel> generateSingleRandomRecipe({
    required int index,
    required String dishType,
    required String cookingMethod,
    required String ageGroup,
    required String difficulty,
  }) async
  {

    final usedRecipesText = _usedRecipeSignatures.isEmpty
        ? "None"
        : _usedRecipeSignatures.join(" | ");

    final body = {
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
          "You are a child-safe cooking instructor. You must NEVER repeat or slightly modify an existing dish."
        },
        {
          "role": "user",
          "content": """
Generate ONE COMPLETELY NEW kid-friendly recipe.

🚫 ALREADY GENERATED DISHES (DO NOT REPEAT OR SIMILARIZE):
$usedRecipesText

STRICT RULES:
• Name must be NEW
• Dish type must be DIFFERENT
• Core ingredients must be DIFFERENT
• Cooking style must be DIFFERENT
• NO sandwich/toast/wrap repeats
• NO flavor variants of same dish

Constraints:
• Dish Type: $dishType
• Cooking Method: $cookingMethod
• Age Group: $ageGroup
• Difficulty: $difficulty

Safety:
• Real food only
• Common household ingredients
• Child-safe steps

If you cannot create a completely new dish,
CREATE A DIFFERENT CATEGORY DISH (snack, bowl, dessert, drink).

OUTPUT JSON ONLY:

OUTPUT JSON ONLY:

{
  "name": "",
  "description": "",
  "cookingTime": "Exact total time (e.g. 15 minutes, 30 minutes total)",
  "ingredients": [],
  "steps": []
}

RULES:
• cookingTime MUST be a string
• MUST NOT be empty
• If no heat is used, include prep or chilling time
"""
        }
      ],
      "response_format": {"type": "json_object"},
      "temperature": 0.7
    };

    final response = await http.post(
      Uri.parse(_chatEndpoint),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_openAiApiKey",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final decoded = jsonDecode(response.body);
    final json =
    jsonDecode(decoded["choices"][0]["message"]["content"]);

    final recipe = RecipeModel.fromJson(json);

    // Save signature to prevent future duplicates
    _usedRecipeSignatures.add(buildRecipeSignature(recipe));

    await attachAiImage(recipe);

    return recipe;
  }






  /// 🧺 Generate recipe from ingredients
  Future<List<RecipeModel>> generateFromIngredients({
    required List<String> ingredients,
    String? notes,
    String dishType = "Hot",
    String cookingMethod = "Gas (Adult Only)",
    String ageGroup = "9–10",
    String difficulty = "With Parent",
  }) async {
    try {
      final body = {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
            "You are a professional chef and child-safe cooking instructor."
          },
          {
            "role": "user",
            "content": """
You MUST generate EXACTLY 5 DISTINCT recipes.

Base ingredient(s):
${ingredients.join(", ")}

CATEGORY ASSIGNMENTS (MANDATORY):
Recipe 1 → Sandwich / Toast / Open-faced
Recipe 2 → Snack / Finger Food
Recipe 3 → Main Course (Indian or International)
Recipe 4 → Baked OR Oven Dish (NOT bread loaf)
Recipe 5 → Sweet OR Fusion Dish

STRICT RULES:
• Dish names MUST be unique
• Cooking techniques MUST differ
• You MAY add extra ingredients
• Recipes must feel REAL & different (Paneer Bhurji ≠ Paneer Butter Masala)

Safety Constraints:
• Dish Type: $dishType
• Cooking Method: $cookingMethod
• Age Group: $ageGroup
• Difficulty: $difficulty

OUTPUT RULES:
• JSON ONLY
• No markdown
• No explanation text

FORMAT:
{
  "recipes": [
    {
      "name": "Dish Name",
      "description": "Short, fun and kid-friendly description",
      "cookingTime": "Exact total time (e.g. 20 minutes, 2–4 hours chilling)",
      "ingredients": ["ingredient1", "ingredient2"],
      "steps": ["Step 1", "Step 2"]
    }
  ]
}

RULES FOR cookingTime:
• MUST be present
• MUST be a readable string
• Include prep + cooking or chilling time

Notes: ${notes ?? "None"}
"""
          }
        ],
        "response_format": {"type": "json_object"},
        "temperature": 0.95
      };

      final response = await http.post(
        Uri.parse(_chatEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_openAiApiKey",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception("OpenAI error: ${response.body}");
      }

      final decoded = jsonDecode(response.body);
      final content =
      jsonDecode(decoded["choices"][0]["message"]["content"]);

      final List recipesJson = content["recipes"] ?? [];

      final recipes = recipesJson
          .map((e) => RecipeModel.fromJson(e))
          .toList();

      // Attach AI images
      for (final recipe in recipes) {
        await attachAiImage(recipe);
      }

      return recipes;
    } catch (e) {
      log("Recipe generation from ingredients failed: $e");
      rethrow;
    }
  }

  Future<RecipeModel> generateSingleRecipeFromIngredients({
    required List<String> ingredients,
    required int index,
    required String dishType,
    required String cookingMethod,
    required String ageGroup,
    required String difficulty,
    String? notes,
  }) async {
    final body = {
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content": "You are a professional chef and child-safe instructor."
        },
        {
          "role": "user",
          "content": """
You are a STRICT rule-following AI chef.

Generate ONE recipe that MUST FOLLOW ALL CONSTRAINTS BELOW.

🔹 BASE INGREDIENTS (MANDATORY):
${ingredients.join(", ")}

🔹 FILTER CONSTRAINTS (NON-NEGOTIABLE):
• Dish Type: $dishType
• Cooking Method: $cookingMethod
• Age Group: $ageGroup
• Difficulty: $difficulty

Recipe index: $index

RULES:
• Dish MUST match Dish Type
• Steps MUST respect Cooking Method
• Language MUST be suitable for Age Group
• Difficulty MUST match exactly
• You MAY add extra ingredients
• Must be DIFFERENT from previous recipes
• Use a DIFFERENT cooking style

🚫 If constraints are not possible, ADAPT the dish while STILL respecting ALL filters.

OUTPUT JSON ONLY (NO MARKDOWN, NO TEXT):

{
  "name": "",
  "description": "",
  "cookingTime": "Exact total time required",
  "ingredients": [],
  "steps": []
}

RULES:
• cookingTime is REQUIRED
• Must be a string (no —, null, or empty)
 
Notes (optional): ${notes ?? "None"}
"""
        }
      ],
      "response_format": {"type": "json_object"},
      "temperature": 0.9
    };

    final response = await http.post(
      Uri.parse(_chatEndpoint),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_openAiApiKey",
      },
      body: jsonEncode(body),
    );

    final decoded = jsonDecode(response.body);
    final json =
    jsonDecode(decoded["choices"][0]["message"]["content"]);

    final recipe = RecipeModel.fromJson(json);
    await attachAiImage(recipe);

    return recipe;
  }



  /// 🔹 Attach AI-generated image to a RecipeModel
  Future<RecipeModel> attachAiImage(RecipeModel recipe) async {
    try {
      // If recipe.name is empty, fallback to "food dish"
      final title = recipe.name.isNotEmpty ? recipe.name : "food dish";
      recipe.imageUrl = await _safeImageGen(title);
    } catch (e) {
      log("Failed to generate image for ${recipe.name}: $e");
      recipe.imageUrl = null;
    }
    return recipe;
  }

  /// 🔹 Generate AI image using OpenAI Images API
  Future<String> _safeImageGen(String title) async {
    final body = {
      "prompt": "High quality food photograph of: $title, appetizing, centered",
      "n": 1,
      "size": "512x512",
    };

    try {
      final response = await http.post(
        Uri.parse(_imageEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_openAiApiKey",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception("Image API error: ${response.body}");
      }

      final decoded = jsonDecode(response.body);
      final url = decoded['data']?[0]?['url'] as String?;

      return url ?? "assets/images/placeholder_recipe_default_02.png";
    } catch (e) {
      log("Image generation failed for $title: $e");
      return "assets/images/placeholder_recipe_default_02.png";
    }
  }
}
