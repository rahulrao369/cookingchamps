class MonthlyChallengeBannerModel {
  int? id;
  String? title;
  String? bannerImage;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  MonthlyChallengeBannerModel({
    this.id,
    this.title,
    this.bannerImage,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  MonthlyChallengeBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bannerImage = json['banner_image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
