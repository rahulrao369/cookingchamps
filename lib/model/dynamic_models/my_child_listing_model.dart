class MyChildListNew {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  MyChildListNew({this.status, this.statusCode, this.message, this.data});

  MyChildListNew.fromJson(Map<String, dynamic> json) {
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
  int? totalPage;
  SubscriptionAmount? subscriptionAmount;
  List<Items>? items;
  bool? isParentPurchaseSubscription;

  Data(
      {this.totalPage,
        this.subscriptionAmount,
        this.items,
        this.isParentPurchaseSubscription});

  Data.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    subscriptionAmount = json['subscription_amount'] != null
        ? new SubscriptionAmount.fromJson(json['subscription_amount'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    isParentPurchaseSubscription = json['is_parent_purchase_subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    if (this.subscriptionAmount != null) {
      data['subscription_amount'] = this.subscriptionAmount!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['is_parent_purchase_subscription'] = this.isParentPurchaseSubscription;
    return data;
  }
}

class SubscriptionAmount {
  String? id;
  String? amount;

  SubscriptionAmount({this.id, this.amount});

  SubscriptionAmount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    return data;
  }
}

class Items {
  String? id;
  String? parentId;
  String? name;
  String? role;
  String? day;
  String? month;
  String? year;
  String? grade;
  String? username;
  String? decryptedPassword;
  String? createdAt;
  String? updatedAt;
  String? image;
  bool? isPurchaseSubscription;
  Subscription? subscription;

  Items(
      {this.id,
        this.parentId,
        this.name,
        this.role,
        this.day,
        this.month,
        this.year,
        this.grade,
        this.username,
        this.decryptedPassword,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.isPurchaseSubscription,
        this.subscription});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    role = json['role'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    grade = json['grade'];
    username = json['username'];
    decryptedPassword = json['decrypted_password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    isPurchaseSubscription = json['is_purchase_subscription'];
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['role'] = this.role;
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    data['grade'] = this.grade;
    data['username'] = this.username;
    data['decrypted_password'] = this.decryptedPassword;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['is_purchase_subscription'] = this.isPurchaseSubscription;
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  String? id;
  String? userId;
  String? kidId;
  String? subscriptionId;
  String? role;
  String? subRole;
  String? transactionId;
  String? stripeProductId;
  String? stripePriceId;
  String? paymentStatus;
  String? startDate;
  String? endDate;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Subscription(
      {this.id,
        this.userId,
        this.kidId,
        this.subscriptionId,
        this.role,
        this.subRole,
        this.transactionId,
        this.stripeProductId,
        this.stripePriceId,
        this.paymentStatus,
        this.startDate,
        this.endDate,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    kidId = json['kid_id'];
    subscriptionId = json['subscription_id'];
    role = json['role'];
    subRole = json['sub_role'];
    transactionId = json['transaction_id'];
    stripeProductId = json['stripe_product_id'];
    stripePriceId = json['stripe_price_id'];
    paymentStatus = json['payment_status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['kid_id'] = this.kidId;
    data['subscription_id'] = this.subscriptionId;
    data['role'] = this.role;
    data['sub_role'] = this.subRole;
    data['transaction_id'] = this.transactionId;
    data['stripe_product_id'] = this.stripeProductId;
    data['stripe_price_id'] = this.stripePriceId;
    data['payment_status'] = this.paymentStatus;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
