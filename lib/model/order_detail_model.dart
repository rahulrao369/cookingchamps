class OrderDetailModel {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  OrderDetailModel({this.status, this.statusCode, this.message, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? uniqueId;
  String? userId;
  String? role;
  String? subRole;
  String? totalAmount;
  String? taxAmount;
  String? discountAmount;
  String? status;
  String? deliveryStatus;
  String? transactionId;
  String? paymentId;
  String? shippingAddressId;
  String? createdAt;
  String? updatedAt;
  String? netAmount;
  List<OrderItem>? orderItem;
  DeliveryAddress? deliveryAddress;

  Data(
      {this.id,
        this.uniqueId,
        this.userId,
        this.role,
        this.subRole,
        this.totalAmount,
        this.taxAmount,
        this.discountAmount,
        this.status,
        this.deliveryStatus,
        this.netAmount,
        this.transactionId,
        this.paymentId,
        this.shippingAddressId,
        this.createdAt,
        this.updatedAt,
        this.orderItem,
        this.deliveryAddress});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    userId = json['user_id'];
    role = json['role'];
    subRole = json['sub_role'];
    netAmount = json['net_amount'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    status = json['status'];
    deliveryStatus = json['delivery_status'];
    transactionId = json['transaction_id'];
    paymentId = json['payment_id'];
    shippingAddressId = json['shipping_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['user_id'] = this.userId;
    data['net_amount'] = this.netAmount;
    data['role'] = this.role;
    data['sub_role'] = this.subRole;
    data['total_amount'] = this.totalAmount;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['status'] = this.status;
    data['delivery_status'] = this.deliveryStatus;
    data['transaction_id'] = this.transactionId;
    data['payment_id'] = this.paymentId;
    data['shipping_address_id'] = this.shippingAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress!.toJson();
    }
    return data;
  }
}

class OrderItem {
  String? id;
  String? orderId;
  String? productId;
  String? productName;
  String? price;
  String? quantity;
  String? subtotal;
  String? createdAt;
  String? updatedAt;

  OrderItem(
      {this.id,
        this.orderId,
        this.productId,
        this.productName,
        this.price,
        this.quantity,
        this.subtotal,
        this.createdAt,
        this.updatedAt});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DeliveryAddress {
  String? id;
  String? parentId;
  String? role;
  Null? subRole;
  String? name;
  String? address;
  String? addressType;
  String? createdAt;
  String? updatedAt;

  DeliveryAddress(
      {this.id,
        this.parentId,
        this.role,
        this.subRole,
        this.name,
        this.address,
        this.addressType,
        this.createdAt,
        this.updatedAt});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
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
