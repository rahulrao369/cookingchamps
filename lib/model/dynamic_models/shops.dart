class Shops {
  bool? status;
  int? statusCode;
  String? message;
  ShopData? data;

  Shops({this.status, this.statusCode, this.message, this.data});

  Shops.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new ShopData.fromJson(json['data']) : null;
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

class ShopData {
  int? totalWishlistItems;
  int? totalCartItems;
  List<Categories>? categories;
  List<Products>? products;

  ShopData(
      {this.totalWishlistItems,
        this.totalCartItems,
        this.categories,
        this.products});

  ShopData.fromJson(Map<String, dynamic> json) {
    totalWishlistItems = json['total_wishlist_items'];
    totalCartItems = json['total_cart_items'];

    // Try reading 'categories', if available
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }

    // Try reading 'items' as products if 'products' is missing
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    } else if (json['items'] != null) {
      products = <Products>[];
      json['items'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_wishlist_items'] = this.totalWishlistItems;
    data['total_cart_items'] = this.totalCartItems;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? name;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Products {
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

  Products(
      {this.id,
        this.vendorId,
        this.isFavourite,
        this.isCartAdded,
        this.productCatId,
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

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFavourite = json['is_favourite'];
    isCartAdded = json['is_cart_added'];
    vendorId = json['vendor_id'];
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
    data['is_favourite'] = this.isFavourite;
    data['is_cart_added'] = this.isCartAdded;
    data['vendor_id'] = this.vendorId;
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
