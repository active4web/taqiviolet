class PMData {
  bool? success;
  int? status;
  String? message;
  Data? data;

  PMData({this.success, this.status, this.message, this.data});

  PMData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? signature;
  String? name;
  String? nationality;
  String? nationalNo;
  String? jobName;
  String? phone;
  String? address;
  String? lastVacation;
  String? startWorkDate;

  Data(
      {this.id,
        this.signature,
        this.name,
        this.nationality,
        this.nationalNo,
        this.jobName,
      this.lastVacation,
      this.phone,
      this.address,
      this.startWorkDate,

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    signature = json['signature'];
    name = json['name'];
    nationality = json['nationality'];
    nationalNo = json['national_no'];
    jobName = json['job_name'];
    phone = json['phone'];
    address = json['address'];
    lastVacation = json['last_vacation'];
    startWorkDate = json['start_work_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['signature'] = this.signature;
    data['name'] = this.name;
    data['nationality'] = this.nationality;
    data['national_no'] = this.nationalNo;
    data['job_name'] = this.jobName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['last_vacation'] = this.lastVacation;
    data['start_work_date'] = this.startWorkDate;
    return data;
  }
}