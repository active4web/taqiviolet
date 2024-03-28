import 'package:safsofa/models/my_orders_model.dart';
import 'package:safsofa/screens/new/financial_reports_screen/models/partner_wating_order_model.dart';

class UserProfileDataModel {
  bool? status;
  dynamic errNum;
  dynamic msg;
  Data? data;

  UserProfileDataModel({this.status, this.errNum, this.msg, this.data});

  UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  UserProfile? userProfile;
  dynamic myOrder;
  MyOrdersData? lastOrder;
  dynamic bonus;
  List<MyList>? myList;
  List<Suggestion>? suggestion;

  Data(
      {this.userProfile,
        this.myOrder,
        this.lastOrder,
        this.bonus,
        this.myList,
        this.suggestion});

  Data.fromJson(Map<String, dynamic> json) {
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    myOrder = json['MyOrder'];
    lastOrder = json['lastOrder'] != null
        ? new MyOrdersData.fromJson(json['lastOrder'])
        : null;
    bonus = json['bonus'];
    if (json['myList'] != null) {
      myList = <MyList>[];
      json['myList'].forEach((v) {
        myList!.add(new MyList.fromJson(v));
      });
    }
    if (json['Suggestion'] != null) {
      suggestion = <Suggestion>[];
      json['Suggestion'].forEach((v) {
        suggestion!.add(new Suggestion.fromJson(v));
      });
    }
  }
}

class UserProfile {
  int? id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic address;
  dynamic firebaseId;
  dynamic lang;
  dynamic image;
  dynamic totalPoint;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isActive;

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
        this.updatedAt,
        this.isActive});

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
    isActive = json['is_active'];
  }

}

class LastOrder {
  dynamic id;
  dynamic codeOrder;
  dynamic createdAt;
  dynamic deliveryDate;

  LastOrder(
      {this.id,
        this.codeOrder,
        this.createdAt,
        this.deliveryDate,
      });

  LastOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    createdAt = json['created_at'];

    deliveryDate = json['delivery_date'];
  }

}

class MyList {
  dynamic id;
  dynamic name;
  dynamic nameSearch;
  dynamic oldPrice;
  dynamic currentPrice;
  dynamic smartPrice;
  dynamic details;
  dynamic quantity;
  dynamic subCategoryId;
  dynamic categoryId;
  dynamic isActive;
  dynamic storeId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic image;
  dynamic deliveryTime;
  dynamic hasFavorites;
  dynamic hasRosters;
  dynamic hasReviews;

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

        this.deliveryTime,
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
    deliveryTime = json['delivery_time'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
  }

}

class Suggestion {
  int? id;
  dynamic name;
  dynamic nameSearch;
  dynamic oldPrice;
  dynamic currentPrice;
  dynamic smartPrice;
  dynamic details;
  dynamic quantity;
  dynamic subCategoryId;
  dynamic categoryId;
  dynamic isActive;
  dynamic storeId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic image;
  dynamic altText;
  dynamic titleImg;
  dynamic slug;
  dynamic serialNo;
  dynamic taxAmount;
  dynamic deliveryTime;
  List<String>? images;
  dynamic hascart;
  dynamic hasFavorites;
  dynamic hasRosters;
  dynamic hasReviews;
  dynamic reviewComment;

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
        this.altText,
        this.titleImg,
        this.slug,
        this.serialNo,
        this.taxAmount,
        this.deliveryTime,
        this.images,
        this.hascart,
        this.hasFavorites,
        this.hasRosters,
        this.hasReviews,
        this.reviewComment});

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
    altText = json['alt_text'];
    titleImg = json['title_img'];
    slug = json['slug'];
    serialNo = json['serial_no'];
    taxAmount = json['tax_amount'];
    deliveryTime = json['delivery_time'];
    images = json['images'].cast<String>();
    hascart = json['hascart'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
    reviewComment = json['ReviewComment'];
  }

}
