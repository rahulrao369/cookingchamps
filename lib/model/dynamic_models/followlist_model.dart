class Followlist {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  Followlist({this.status, this.statusCode, this.message, this.data});

  Followlist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<MyFollowers>? myFollowers;
  List<IAmFollowing>? iAmFollowing;

  Data({this.myFollowers, this.iAmFollowing});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_followers'] != null) {
      myFollowers = <MyFollowers>[];
      json['my_followers'].forEach((v) {
        myFollowers!.add(new MyFollowers.fromJson(v));
      });
    }
    if (json['I_am_following'] != null) {
      iAmFollowing = <IAmFollowing>[];
      json['I_am_following'].forEach((v) {
        iAmFollowing!.add(new IAmFollowing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myFollowers != null) {
      data['my_followers'] = this.myFollowers!.map((v) => v.toJson()).toList();
    }
    if (this.iAmFollowing != null) {
      data['I_am_following'] =
          this.iAmFollowing!.map((v) => v).toList();
    }
    return data;
  }
}

class MyFollowers {
  String? id;
  String? senderId;
  String? receiverId;
  String? followReqSentBy;
  String? followReqSentTo;
  String? createdAt;
  String? updatedAt;
  UserDetails? userDetails;

  MyFollowers(
      {this.id,
        this.senderId,
        this.receiverId,
        this.followReqSentBy,
        this.followReqSentTo,
        this.createdAt,
        this.updatedAt,
        this.userDetails});

  MyFollowers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    followReqSentBy = json['follow_req_sent_by'];
    followReqSentTo = json['follow_req_sent_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['follow_req_sent_by'] = this.followReqSentBy;
    data['follow_req_sent_to'] = this.followReqSentTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class IAmFollowing {
  String? id;
  String? senderId;
  String? receiverId;
  String? followReqSentBy;
  String? followReqSentTo;
  String? createdAt;
  String? updatedAt;
  UserDetails? userDetails;

  IAmFollowing(
      {this.id,
        this.senderId,
        this.receiverId,
        this.followReqSentBy,
        this.followReqSentTo,
        this.createdAt,
        this.updatedAt,
        this.userDetails});

  IAmFollowing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    followReqSentBy = json['follow_req_sent_by'];
    followReqSentTo = json['follow_req_sent_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['follow_req_sent_by'] = this.followReqSentBy;
    data['follow_req_sent_to'] = this.followReqSentTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}
class UserDetails {
  String? id;
  Null? loginType;
  String? firstName;
  String? lastName;
  String? role;
  String? email;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? parentId;
  String? name;
  String? day;
  String? month;
  String? year;
  String? grade;
  String? username;
  String? password;
  String? decryptedPassword;
  String? friendrequeststatus;

  UserDetails(
      {this.id,
        this.loginType,
        this.firstName,
        this.lastName,
        this.role,
        this.email,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.parentId,
        this.name,
        this.day,
        this.month,
        this.year,
        this.grade,
        this.username,
        this.password,
         this.decryptedPassword,
         this.friendrequeststatus
       });

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginType = json['login_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentId = json['parent_id'];
    name = json['name'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    grade = json['grade'];
    username = json['username'];
    password = json['password'];
    decryptedPassword = json['decrypted_password'];
    friendrequeststatus = json['friend_request_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_type'] = this.loginType;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['role'] = this.role;
    data['email'] = this.email;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    data['grade'] = this.grade;
    data['username'] = this.username;
    data['password'] = this.password;
    data['decrypted_password'] = this.decryptedPassword;
    data['friend_request_status'] = this.friendrequeststatus;
    return data;
  }
}
