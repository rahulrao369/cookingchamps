class GrowingActivityModel {
  int? id;
  String? title;
  String? image;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  GrowingActivityModel({
    this.id,
    this.title,
    this.image,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  GrowingActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
