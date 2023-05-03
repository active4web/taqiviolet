class CitiesLocationsModel {
  bool? status;
  String? errNum;
  String? msg;
  CityLocationData? data;

  CitiesLocationsModel({this.status, this.errNum, this.msg, this.data});

  CitiesLocationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new CityLocationData.fromJson(json['data']) : null;
  }

  // Map<String?, dynamic> toJson() {
  //   final Map<String?, dynamic> data = new Map<String?, dynamic>();
  //   data['status'] = this.status;
  //   data['errNum'] = this.errNum;
  //   data['msg'] = this.msg;
  //   if (this.data != null) {
  //     data['data'] = this.data.toJson();
  //   }
  //   return data;
  // }
}

class CityLocationData {
  List<CountryList>? countryList;

  CityLocationData({this.countryList});

  CityLocationData.fromJson(Map<String, dynamic> json) {
    if (json['country_list'] != null) {
      countryList = <CountryList>[];
      json['country_list'].forEach((v) {
        countryList!.add(new CountryList.fromJson(v));
      });
    }
  }

  // Map<String?, dynamic> toJson() {
  //   final Map<String?, dynamic> data = new Map<String?, dynamic>();
  //   if (this.countryList != null) {
  //     data['country_list'] = this.countryList.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class CountryList {
  String? name;
  int? id;
  List<ListCites>? listCites;

  CountryList({this.name, this.id, this.listCites});

  CountryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['list_cites'] != null) {
      listCites = <ListCites>[];
      json['list_cites'].forEach((v) {
        listCites!.add(new ListCites.fromJson(v));
      });
    }
  }

  // Map<String?, dynamic> toJson() {
  //   final Map<String?, dynamic> data = new Map<String?, dynamic>();
  //   data['name'] = this.name;
  //   data['id'] = this.id;
  //   data['list_cites'] = this.listCites.map((v) => v.toJson()).toList();
  //   return data;
  // }
}

class ListCites {
  String? nameCity;
  int? idCity;

  ListCites({this.nameCity, this.idCity});

  ListCites.fromJson(Map<String, dynamic> json) {
    nameCity = json['name_city'];
    idCity = json['id_city'];
  }

  // Map<String?, dynamic> toJson() {
  //   final Map<String?, dynamic> data = new Map<String?, dynamic>();
  //   data['name_city'] = this.nameCity;
  //   data['id_city'] = this.idCity;
  //   return data;
  // }
}
