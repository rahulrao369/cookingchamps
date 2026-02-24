class AddRecipeRequest {
  String? recipeId;
  String? recipeName;
  String? recipeTools;
  String? ingredients;
  String? recipeSteps;
  String? recipeVideolink;
  AddRecipeRequest(
      {this.recipeId,this.recipeName, this.recipeTools, this.ingredients, this.recipeSteps,this.recipeVideolink});

  AddRecipeRequest.fromJson(Map<String, dynamic> json) {

    recipeId = json['recipe_id'];
    recipeName = json['recipe_name'];
    recipeTools = json['recipe_tools'];
    ingredients = json['ingredients'];
    recipeSteps = json['recipe_steps'];
    recipeVideolink = json['video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe_id'] = recipeId;
    data['recipe_name'] = recipeName;
    data['recipe_tools'] = recipeTools;
    data['ingredients'] = ingredients;
    data['recipe_steps'] = recipeSteps;
    data['video_link']= recipeVideolink;
    return data;
  }
}