class UserProfileDataModel {
  bool status;
  String errNum;
  String msg;
  AccountData data;

  UserProfileDataModel({this.status, this.errNum, this.msg, this.data});

  UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ?  AccountData.fromJson(json['data']) : null;
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

class AccountData {
  UserProfile userProfile;
  int myOrder;
  String lastOrder;
  String bonus;
  List<MyList> myList;
  List<Suggestion> suggestion;

  AccountData(
      {this.userProfile,
      this.myOrder,
      this.lastOrder,
      this.bonus,
      this.myList,
      this.suggestion});

  AccountData.fromJson(Map<String, dynamic> json) {
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    myOrder = json['MyOrder'];
    lastOrder = json['lastOrder'];
    bonus = json['bonus'];
    if (json['myList'] != null) {
      myList = new List<MyList>();
      json['myList'].forEach((v) {
        myList.add(new MyList.fromJson(v));
      });
    }
    if (json['Suggestion'] != null) {
      suggestion = new List<Suggestion>();
      json['Suggestion'].forEach((v) {
        suggestion.add(new Suggestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    data['MyOrder'] = this.myOrder;
    data['lastOrder'] = this.lastOrder;
    data['bonus'] = this.bonus;
    if (this.myList != null) {
      data['myList'] = this.myList.map((v) => v.toJson()).toList();
    }
    if (this.suggestion != null) {
      data['Suggestion'] = this.suggestion.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProfile {
  int id;
  String name;
  String email;
  String phone;
  String address;
  String firebaseId;
  String lang;
  String image;
  Null totalPoint;
  String createdAt;
  String updatedAt;

  UserProfile(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.firebaseId,
      this.lang,
      this.image,
      this.totalPoint,
      this.createdAt,
      this.updatedAt});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    firebaseId = json['firebase_id'];
    lang = json['lang'];
    image = json['image'];
    totalPoint = json['total_point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['firebase_id'] = this.firebaseId;
    data['lang'] = this.lang;
    data['image'] = this.image;
    data['total_point'] = this.totalPoint;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MyList {
  int id;
  String name;
  String nameSearch;
  int oldPrice;
  int currentPrice;
  int smartPrice;
  String details;
  String quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String image;
  Null altText;
  Null titleImg;
  Null slug;
  Null serialNo;
  Null taxAmount;
  int hasFavorites;
  int hasRosters;
  String hasReviews;

  MyList(
      {this.id,
      this.name,
      this.nameSearch,
      this.oldPrice,
      this.currentPrice,
      this.smartPrice,
      this.details,
      this.quantity,
      this.subCategoryId,
      this.categoryId,
      this.isActive,
      this.storeId,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.altText,
      this.titleImg,
      this.slug,
      this.serialNo,
      this.taxAmount,
      this.hasFavorites,
      this.hasRosters,
      this.hasReviews});

  MyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameSearch = json['name_search'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    smartPrice = json['smart_price'];
    details = json['details'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    altText = json['alt_text'];
    titleImg = json['title_img'];
    slug = json['slug'];
    serialNo = json['serial_no'];
    taxAmount = json['tax_amount'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_search'] = this.nameSearch;
    data['old_price'] = this.oldPrice;
    data['current_price'] = this.currentPrice;
    data['smart_price'] = this.smartPrice;
    data['details'] = this.details;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['alt_text'] = this.altText;
    data['title_img'] = this.titleImg;
    data['slug'] = this.slug;
    data['serial_no'] = this.serialNo;
    data['tax_amount'] = this.taxAmount;
    data['hasFavorites'] = this.hasFavorites;
    data['hasRosters'] = this.hasRosters;
    data['hasReviews'] = this.hasReviews;
    return data;
  }
}

class Suggestion {
  int id;
  String name;
  String nameSearch;
  int oldPrice;
  int currentPrice;
  int smartPrice;
  String details;
  String quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String image;

  String serialNo;
  String taxAmount;
  List<String> images;
  int hascart;
  int hasFavorites;
  int hasRosters;
  String hasReviews;

  Suggestion(
      {this.id,
      this.name,
      this.nameSearch,
      this.oldPrice,
      this.currentPrice,
      this.smartPrice,
      this.details,
      this.quantity,
      this.subCategoryId,
      this.categoryId,
      this.isActive,
      this.storeId,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.serialNo,
      this.taxAmount,
      this.images,
      this.hascart,
      this.hasFavorites,
      this.hasRosters,
      this.hasReviews});

  Suggestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameSearch = json['name_search'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    smartPrice = json['smart_price'];
    details = json['details'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    serialNo = json['serial_no'];
    taxAmount = json['tax_amount'];
    images = json['images'].cast<String>();
    hascart = json['hascart'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_search'] = this.nameSearch;
    data['old_price'] = this.oldPrice;
    data['current_price'] = this.currentPrice;
    data['smart_price'] = this.smartPrice;
    data['details'] = this.details;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['serial_no'] = this.serialNo;
    data['tax_amount'] = this.taxAmount;
    data['images'] = this.images;
    data['hascart'] = this.hascart;
    data['hasFavorites'] = this.hasFavorites;
    data['hasRosters'] = this.hasRosters;
    data['hasReviews'] = this.hasReviews;
    return data;
  }
}
