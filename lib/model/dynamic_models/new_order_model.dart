class NewOrderModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  NewOrderModel({this.status, this.statusCode, this.message, this.data});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? uniqueId;
  String? deliveryStatus;
  String? totalAmount;
  String? orderDate;

  Data({this.id, this.uniqueId,this.deliveryStatus, this.totalAmount, this.orderDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    deliveryStatus = json['delivery_status'];
    totalAmount = json['total_amount'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['delivery_status'] = this.deliveryStatus;
    data['total_amount'] = this.totalAmount;
    data['order_date'] = this.orderDate;
    return data;
  }
}
