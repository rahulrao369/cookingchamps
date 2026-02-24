class ParentRegisterModel {
  String? role;
  String? firstName;
  String? mobileNumber;
  String? countryCode;
  String? lastName;
  // String? image;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? fcmToken;
  String? deviceId;
  String? deviceType;

  String? loginType;
  String? image;

  ParentRegisterModel({
    this.role,
    this.firstName,
    this.mobileNumber,
    this.countryCode,
    this.lastName,
    // this.image,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.fcmToken,
    this.deviceId,
    this.deviceType,
    this.loginType,
    this.image,
  });

  ParentRegisterModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    firstName = json['first_name'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    lastName = json['last_name'];
    // image = json['Image'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    fcmToken = json['fcm_token'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    loginType = json['login_type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['first_name'] = firstName;
    data['mobile_number'] = mobileNumber;
    data['country_code'] = countryCode;
    data['last_name'] = lastName;
    // data['Image'] = image;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['fcm_token'] = fcmToken;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['login_type'] = loginType;
    data['image'] = image;
    return data;
  }
}
