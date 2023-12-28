class DetailsSupportModel {
  bool? status;
  String? errNum;
  String? msg;
  List<DetailsSupportData>? data;

  DetailsSupportModel({this.status, this.errNum, this.msg, this.data});

  DetailsSupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <DetailsSupportData>[];
      json['data'].forEach((v) {
        data!.add(new DetailsSupportData.fromJson(v));
      });
    }
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['status'] = this.status;
//   data['errNum'] = this.errNum;
//   data['msg'] = this.msg;
//   if (this.data != null) {
//     data['data'] = this.data.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class DetailsSupportData {
  int? id;
  String? name;
  String? phone;
  String? message;
  int? status;
  int? isActive;
  String? notes;
  String? createdAt;
  String? updatedAt;

  DetailsSupportData(
      {this.id,
      this.name,
      this.phone,
      this.message,
      this.status,
      this.isActive,
      this.notes,
      this.createdAt,
      this.updatedAt});

  DetailsSupportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    message = json['message'];
    status = json['status'];
    isActive = json['is_active'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['phone'] = this.phone;
//   data['message'] = this.message;
//   data['status'] = this.status;
//   data['is_active'] = this.isActive;
//   data['notes'] = this.notes;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   return data;
// }
}
