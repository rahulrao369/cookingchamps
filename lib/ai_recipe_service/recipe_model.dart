class RecipeModel {
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  final String cookingTime; // ✅ NEW (e.g. "25 minutes")

  String? imageUrl;

  RecipeModel({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
    this.imageUrl,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name']?.toString() ??
          json['recipe_name']?.toString() ??
          '',

      description: json['description']?.toString() ??
          json['summary']?.toString() ??
          '',

      cookingTime: json['cookingTime']?.toString() ??
          json['cook_time']?.toString() ??
          json['time']?.toString() ??
          '—',

      ingredients: _parseList(
        json['ingredients'] ?? json['ingredient_list'],
        fallbackKey: 'name',
      ),

      steps: _parseList(
        json['steps'] ?? json['instructions'],
        fallbackKey: 'text',
      ),

      imageUrl: json['imageUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
      'steps': steps,
      'imageUrl': imageUrl,
    };
  }

  static List<String> _parseList(
      dynamic value, {
        required String fallbackKey,
      }) {
    if (value == null) return [];

    if (value is List) {
      return value
          .map((e) {
        if (e is String) return e;
        if (e is Map && e[fallbackKey] != null) {
          return e[fallbackKey].toString();
        }
        return '';
      })
          .where((e) => e.trim().isNotEmpty)
          .toList();
    }

    if (value is String) {
      return [value];
    }

    return [];
  }

  @override
  String toString() {
    return '''
RecipeModel(
  name: $name,
  cookingTime: $cookingTime,
  ingredients: ${ingredients.length},
  steps: ${steps.length}
)
''';
  }
}
