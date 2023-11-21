class InfractionModel {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  InfractionModel({this.success, this.status, this.message, this.data});

  InfractionModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? employeeId;
  int? resourceId;
  int? approve;
  String? infraction;
  String? punishment;
  String? procedure;
  String? signature;
  String? directorSignature;
  String? generalManager;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.managerId,
        this.date,
        this.employeeId,
        this.resourceId,
        this.approve,
        this.infraction,
        this.punishment,
        this.procedure,
        this.signature,
        this.directorSignature,
        this.generalManager,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    managerId = json['manager_id'];
    date = json['date'];
    employeeId = json['employee_id'];
    resourceId = json['resource_id'];
    approve = json['approve'];
    infraction = json['infraction'];
    punishment = json['punishment'];
    procedure = json['procedure'];
    signature = json['signature'];
    directorSignature = json['director_signature'];
    generalManager = json['general_manager'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manager_id'] = this.managerId;
    data['date'] = this.date;
    data['employee_id'] = this.employeeId;
    data['resource_id'] = this.resourceId;
    data['approve'] = this.approve;
    data['infraction'] = this.infraction;
    data['punishment'] = this.punishment;
    data['procedure'] = this.procedure;
    data['signature'] = this.signature;
    data['director_signature'] = this.directorSignature;
    data['general_manager'] = this.generalManager;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}