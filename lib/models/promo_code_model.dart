class PromoCodeModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  PromoCodeModel({this.status, this.errNum, this.msg, this.data});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Code? code;

  Data({this.code});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.code != null) {
      data['code'] = this.code!.toJson();
    }
    return data;
  }
}

class Code {
  int? id;
  String? code;
  int? value;
  String? status;
  String? startDate;
  String? end;
  int? counts;
  int? main;
  int? clientId;
  Null? createdAt;
  String? updatedAt;

  Code(
      {this.id,
        this.code,
        this.value,
        this.status,
        this.startDate,
        this.end,
        this.counts,
        this.main,
        this.clientId,
        this.createdAt,
        this.updatedAt});

  Code.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    status = json['status'];
    startDate = json['start_date'];
    end = json['end'];
    counts = json['counts'];
    main = json['main'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end'] = this.end;
    data['counts'] = this.counts;
    data['main'] = this.main;
    data['client_id'] = this.clientId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}