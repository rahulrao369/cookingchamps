class LoginRequestModel {
  String? email;
  String? username;
  String? password;
  String? fcmToken;
  String? deviceId;
  String? deviceType;

  LoginRequestModel(
      {this.email,
       this.username,
        this.password,
        this.fcmToken,
        this.deviceId,
        this.deviceType});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
    fcmToken = json['fcm_token'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (email != null && email!.isNotEmpty) data['email'] = email;
    if (username != null && username!.isNotEmpty) data['username'] = username;
    if (password != null && password!.isNotEmpty) data['password'] = password;
    if (fcmToken != null && fcmToken!.isNotEmpty) data['fcm_token'] = fcmToken;
    if (deviceId != null && deviceId!.isNotEmpty) data['device_id'] = deviceId;
    if (deviceType != null && deviceType!.isNotEmpty) data['device_type'] = deviceType;

    return data;
  }

}




class ShopsRequestModel {
  String? catId;
  String? type;

  ShopsRequestModel(
      {this.catId,
       this.type,
      });

  ShopsRequestModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (catId != null && catId!.isNotEmpty) data['cat_id'] = catId;
    if (type != null && type!.isNotEmpty) data['type'] = type;

    return data;
  }

}