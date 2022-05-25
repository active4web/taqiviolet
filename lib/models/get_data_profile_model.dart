class GetdataprofileModel {
  int id;
  String name;
  String email;
  String phone;
  String countryId;
  String cityId;
  String address;
  String firebaseId;
  String lang;
  String image;
  String totalPoint;
  String createdAt;
  String updatedAt;

  GetdataprofileModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.countryId,
        this.cityId,
        this.address,
        this.firebaseId,
        this.lang,
        this.image,
        this.totalPoint,
        this.createdAt,
        this.updatedAt});

  GetdataprofileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryId = json['country_id'];
    cityId = json['city_id'];
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
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
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
