class UserIdentityModel {
  String? parentId;
  String? name;
  String? role;
  String? kidImage;
  String? day;
  String? month;
  String? year;
  String? grade;
  String? username;
  String? password;
  String? updatedAt;
  String? createdAt;
  String? id;
  bool? isPurchaseSubscription;
  String? friendRequestId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? deletedAt;
  String? fcmToken;
  String? deviceId;
  String? deviceType;
  String? token;
  String? friendRequestStatus;
  String? followers;
  String? following;
  String? followRequestStatus;

  UserIdentityModel({
    this.parentId,
    this.name,
    this.role,
    this.kidImage,
    this.day,
    this.month,
    this.year,
    this.grade,
    this.username,
    this.password,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.deletedAt,
    this.fcmToken,
    this.deviceId,
    this.deviceType,
    this.token,
    this.friendRequestStatus,
    this.isPurchaseSubscription,
    this.followers,
    this.following,
    this.followRequestStatus,
    this.friendRequestId,
  });

  UserIdentityModel.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'].toString();
    name = json['name'].toString();
    role = json['role'].toString();
    kidImage = json['kid_image'].toString();
    day = json['day'].toString();
    month = json['month'].toString();
    year = json['year'].toString();
    grade = json['grade'].toString();
    username = json['username'].toString();
    password = json['password'].toString();
    updatedAt = json['updated_at'].toString();
    createdAt = json['created_at'].toString();
    isPurchaseSubscription = json['is_purchase_subscription'];
    id = json['id'].toString();
    friendRequestId = json['friend_request_id'];
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    image = json['image'].toString();
    deletedAt = json['deleted_at'].toString();
    fcmToken = json['fcm_token'].toString();
    deviceId = json['device_id'].toString();
    deviceType = json['device_type'].toString();
    token = json['token'].toString();
    friendRequestStatus = json['friend_request_status'].toString();
    followers = json['followers'].toString();
    following = json['following'].toString();
    followRequestStatus = json['follow_request_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = parentId;
    data['name'] = name;
    data['role'] = role;
    data['kid_image'] = kidImage;
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    data['is_purchase_subscription'] = this.isPurchaseSubscription;
    data['grade'] = grade;
    data['username'] = username;
    data['password'] = password;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['friend_request_id'] = friendRequestId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['fcm_token'] = fcmToken;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['token'] = token;
    data['friend_request_status'] = friendRequestStatus;
    data['followers'] = followers;
    data['following'] = following;
    data['follow_request_status'] = this.followRequestStatus;
    return data;
  }
}
