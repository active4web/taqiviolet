class EmployeeDataModel {
  bool? success;
  int? status;
  Message? message;
  String? data;

  EmployeeDataModel({this.success, this.status, this.message, this.data});

  EmployeeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Message {
  List<Listemployess>? listemployess;

  Message({this.listemployess});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['listemployess'] != null) {
      listemployess = <Listemployess>[];
      json['listemployess'].forEach((v) {
        listemployess!.add(new Listemployess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listemployess != null) {
      data['listemployess'] =
          this.listemployess!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listemployess {
  int? employeeId;
  String? employeeName;
  String? employeeNationalNo;
  String? employeeDepartmentName;
  String? employeeNationality;
  String? employeePhone;
  String? employeeStartWorkDate;
  String? employeeJob;
  String? employeeAddress;
  String? employeeLastVacationData;

  Listemployess(
      {this.employeeId,
        this.employeeName,
        this.employeeNationalNo,
        this.employeeNationality,
        this.employeeDepartmentName,
        this.employeePhone,
        this.employeeJob,
      this.employeeStartWorkDate,
      this.employeeLastVacationData,
      this.employeeAddress,
      });

  Listemployess.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeeDepartmentName = json['department'];
    employeeNationalNo = json['employee_national_no'];
    employeeNationality = json['employee_nationality'];
    employeePhone = json['employee_phone'];
    employeeJob = json['employee_job'];
    employeeStartWorkDate = json['start_work'];
    employeeLastVacationData = json['last_vacation'];
    employeeAddress = json['employee_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['employee_national_no'] = this.employeeNationalNo;
    data['department'] = this.employeeDepartmentName;
    data['employee_nationality'] = this.employeeNationality;
    data['employee_phone'] = this.employeePhone;
    data['employee_job'] = this.employeeJob;
    data['start_work'] = this.employeeStartWorkDate;
    data['last_vacation'] = this.employeeLastVacationData;
    data['employee_address'] = this.employeeAddress;
    return data;
  }
}