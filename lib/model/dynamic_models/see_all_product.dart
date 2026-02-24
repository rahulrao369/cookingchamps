class SeeAllProductModel {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  SeeAllProductModel({this.status, this.statusCode, this.message, this.data});

  SeeAllProductModel.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;

  Data({this.totalPage, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? vendorId;
  bool? isFavourite;
  bool? isCartAdded;
  String? productCatId;
  String? title;
  String? image;
  String? description;
  String? addedBy;
  String? quantity;
  String? sellingPrice;
  String? costPrice;
  String? discountPrice;
  String? isFeatured;
  String? status;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
        this.vendorId,
        this.productCatId,
        this.isCartAdded,
        this.isFavourite,
        this.title,
        this.image,
        this.description,
        this.addedBy,
        this.quantity,
        this.sellingPrice,
        this.costPrice,
        this.discountPrice,
        this.isFeatured,
        this.status,
        this.createdAt,
        this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    isCartAdded = json['is_cart_added'];
    isFavourite = json['is_favourite'];
    productCatId = json['product_cat_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    addedBy = json['added_by'];
    quantity = json['quantity'];
    sellingPrice = json['selling_price'];
    costPrice = json['cost_price'];
    discountPrice = json['discount_price'];
    isFeatured = json['is_featured'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['is_favourite'] = this.isFavourite;
    data['is_cart_added'] = this.isCartAdded;
    data['product_cat_id'] = this.productCatId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['added_by'] = this.addedBy;
    data['quantity'] = this.quantity;
    data['selling_price'] = this.sellingPrice;
    data['cost_price'] = this.costPrice;
    data['discount_price'] = this.discountPrice;
    data['is_featured'] = this.isFeatured;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
