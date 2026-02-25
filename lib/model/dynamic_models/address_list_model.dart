class AddressListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  AddressListModel({this.status, this.statusCode, this.message, this.data});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? parentId;
  String? role;
  String? subRole;
  String? name;
  String? address;
  String? addressType;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.parentId,
        this.role,
        this.subRole,
        this.name,
        this.address,
        this.addressType,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    role = json['role'];
    subRole = json['sub_role'];
    name = json['name'];
    address = json['address'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['role'] = this.role;
    data['sub_role'] = this.subRole;
    data['name'] = this.name;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
