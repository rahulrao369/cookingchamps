class AddFavoriteRequest {
  int? recipeId;

  AddFavoriteRequest({this.recipeId});

  AddFavoriteRequest.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipe_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe_id'] = recipeId;
    return data;
  }
}


class UpdateRoleRequest {
  String? roleType;

  UpdateRoleRequest({this.roleType});

  UpdateRoleRequest.fromJson(Map<String, dynamic> json) {
    roleType = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = roleType;
    return data;
  }
}