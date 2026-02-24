class SchoolStoriesModel {
  String? status;
  int? code;
  List<SchoolStoryData>? data;

  SchoolStoriesModel({this.status, this.code, this.data});

  SchoolStoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = <SchoolStoryData>[];
      json['data'].forEach((v) {
        data!.add(new SchoolStoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SchoolStoriesModel{status: $status, code: $code, data: $data}';
  }
}

class SchoolStoryData {
  int? id;
  String? email;
  String? schoolName;
  String? schoolLogo;
  String? contactPersonName;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Videos>? videos;

  SchoolStoryData(
      {this.id,
        this.email,
        this.schoolName,
        this.schoolLogo,
        this.contactPersonName,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.videos});

  SchoolStoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    schoolName = json['school_name'];
    schoolLogo = json['school_logo'];
    contactPersonName = json['contact_person_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['school_name'] = this.schoolName;
    data['school_logo'] = this.schoolLogo;
    data['contact_person_name'] = this.contactPersonName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SchoolStoryData{id: $id, email: $email, schoolName: $schoolName, schoolLogo: $schoolLogo, contactPersonName: $contactPersonName, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, videos: $videos}';
  }
}

class Videos {
  int? id;
  String? schoolId;
  String? title;
  String? description;
  String? videoPath;
  String? thumbnailImage;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Videos(
      {this.id,
        this.schoolId,
        this.title,
        this.description,
        this.videoPath,
        this.thumbnailImage,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    title = json['title'];
    description = json['description'];
    videoPath = json['video_path'];
    thumbnailImage = json['thumbnail_image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_id'] = this.schoolId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['video_path'] = this.videoPath;
    data['thumbnail_image'] = this.thumbnailImage;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Videos{id: $id, schoolId: $schoolId, title: $title, description: $description, videoPath: $videoPath, thumbnailImage: $thumbnailImage, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
