class MembershipListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  MembershipListModel({this.status, this.statusCode, this.message, this.data});

  MembershipListModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? name;
  String? amount;
  bool? isPlanPurchase;
  String? stripeProductId;
  String? stripePriceId;
  String? createdAt;
  String? updatedAt;
  List<SubscriptionDetails>? subscriptionDetails;

  Data(
      {this.id,
        this.type,
        this.name,
        this.amount,
        this.stripeProductId,
        this.isPlanPurchase,
        this.stripePriceId,
        this.createdAt,
        this.updatedAt,
        this.subscriptionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    amount = json['amount'];
    isPlanPurchase = json['is_plan_purchase'];
    stripeProductId = json['stripe_product_id'];
    stripePriceId = json['stripe_price_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subscription_details'] != null) {
      subscriptionDetails = <SubscriptionDetails>[];
      json['subscription_details'].forEach((v) {
        subscriptionDetails!.add(new SubscriptionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['is_plan_purchase'] = this.isPlanPurchase;
    data['stripe_product_id'] = this.stripeProductId;
    data['stripe_price_id'] = this.stripePriceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subscriptionDetails != null) {
      data['subscription_details'] =
          this.subscriptionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionDetails {
  String? id;
  String? subscriptionId;
  String? title;

  SubscriptionDetails({this.id, this.subscriptionId, this.title});

  SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionId = json['subscription_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscription_id'] = this.subscriptionId;
    data['title'] = this.title;
    return data;
  }
}
