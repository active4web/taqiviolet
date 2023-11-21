class ReceiptRecordModel {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  ReceiptRecordModel({this.success, this.status, this.message, this.data});

  ReceiptRecordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? managerId;
  int? employeeId;
  int? resourceId;
  String? signature;
  int? approve;
  String? date;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.managerId,
        this.employeeId,
        this.resourceId,
        this.signature,
        this.approve,
        this.date,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    managerId = json['manager_id'];
    employeeId = json['employee_id'];
    resourceId = json['resource_id'];
    signature = json['signature'];
    approve = json['approve'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manager_id'] = this.managerId;
    data['employee_id'] = this.employeeId;
    data['resource_id'] = this.resourceId;
    data['signature'] = this.signature;
    data['approve'] = this.approve;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}