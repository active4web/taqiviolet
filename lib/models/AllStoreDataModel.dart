class AllStoreDataModel {
  bool status;
  String errNum;
  String msg;
  AllStoreDta data;

  AllStoreDataModel({this.status, this.errNum, this.msg, this.data});

  AllStoreDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new AllStoreDta.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AllStoreDta {
  List<Category> category;
  List<SubCategory> subCategory;
  List<Product> product;

  AllStoreDta({this.category, this.subCategory, this.product});

  AllStoreDta.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  String image;
  String description;
  int isActive;
  String createdAt;
  String updatedAt;
  int storeId;
  int hasSubCategories;

  Category(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.storeId,
        this.hasSubCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeId = json['store_id'];
    hasSubCategories = json['hasSubCategories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['store_id'] = this.storeId;
    data['hasSubCategories'] = this.hasSubCategories;
    return data;
  }
}

class SubCategory {
  int iD;
  String name;
  String details;
  String image;
  int categoryId;

  SubCategory({this.iD, this.name, this.details, this.image, this.categoryId});

  SubCategory.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    details = json['Details'];
    image = json['Image'];
    categoryId = json['Category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Details'] = this.details;
    data['Image'] = this.image;
    data['Category_id'] = this.categoryId;
    return data;
  }
}

class Product {
  int id;
  String name;
  String price;
  String discount;
  String details;
  String quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String images;
  int hasFavorites;
  int hasReviews;

  Product(
      {this.id,
        this.name,
        this.price,
        this.discount,
        this.details,
        this.quantity,
        this.subCategoryId,
        this.categoryId,
        this.isActive,
        this.storeId,
        this.createdAt,
        this.updatedAt,
        this.images,
        this.hasFavorites,
        this.hasReviews});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    details = json['details'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    images = json['images'];
    hasFavorites = json['hasFavorites'];
    hasReviews = json['hasReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['details'] = this.details;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['images'] = this.images;
    data['hasFavorites'] = this.hasFavorites;
    data['hasReviews'] = this.hasReviews;
    return data;
  }
}
