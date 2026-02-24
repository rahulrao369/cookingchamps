class CardListModel {
  bool? status;
  String? message;
  Data? data;

  CardListModel({this.status, this.message, this.data});

  CardListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Items>? items;
  String? subtotal;
  String? tax;
  String? total;
  String? role;

  Data({this.items, this.subtotal,this.role, this.tax, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    tax = json['tax'];
    role = json['role'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = this.subtotal;
    data['role'] = this.role;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}

class Items {
  String? cartId;
  String? productId;
  String? productName;
  String? image;
  String? price;
  String? quantity;
  String? totalPrice;

  Items(
      {this.cartId,
        this.productId,
        this.productName,
        this.image,
        this.price,
        this.quantity,
        this.totalPrice});

  Items.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    return data;
  }
}
