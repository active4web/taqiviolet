class VacationModel {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  VacationModel({this.success, this.status, this.message, this.data});

  VacationModel.fromJson(Map<String, dynamic> json) {
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
  String? from;
  String? to;
  int? type;
  int? ticketRequirement;
  int? replacement;
  String? address;
  String? phone;
  String? signature;
  String? decision;
  String? generalManager;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.managerId,
        this.employeeId,
        this.approve,
        this.from,
        this.to,
        this.type,
        this.ticketRequirement,
        this.replacement,
        this.address,
        this.phone,
        this.signature,
        this.decision,
        this.generalManager,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    managerId = json['manager_id'];
    employeeId = json['employee_id'];
    approve = json['approve'];
    from = json['from'];
    to = json['to'];
    type = json['type'];
    ticketRequirement = json['ticket_requirement'];
    replacement = json['replacement'];
    address = json['address'];
    phone = json['phone'];
    signature = json['signature'];
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
    data['from'] = this.from;
    data['to'] = this.to;
    data['type'] = this.type;
    data['ticket_requirement'] = this.ticketRequirement;
    data['replacement'] = this.replacement;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['signature'] = this.signature;
    data['decision'] = this.decision;
    data['general_manager'] = this.generalManager;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}