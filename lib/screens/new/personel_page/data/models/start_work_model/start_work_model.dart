class StartWorkModel {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  StartWorkModel({this.success, this.status, this.message, this.data});

  StartWorkModel.fromJson(Map<String, dynamic> json) {
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
  int? approve;
  String? date;
  String? employeeSignature;
  String? decision;
  String? generalManager;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.managerId,
        this.employeeId,
        this.approve,
        this.date,
        this.employeeSignature,
        this.decision,
        this.generalManager,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    managerId = json['manager_id'];
    employeeId = json['employee_id'];
    approve = json['approve'];
    date = json['date'];
    employeeSignature = json['employee_signature'];
    decision = json['decision'];
    generalManager = json['general_manager'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manager_id'] = this.managerId;
    data['employee_id'] = this.employeeId;
    data['approve'] = this.approve;
    data['date'] = this.date;
    data['employee_signature'] = this.employeeSignature;
    data['decision'] = this.decision;
    data['general_manager'] = this.generalManager;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}