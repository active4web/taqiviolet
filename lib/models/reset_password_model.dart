class ResetPasswordModel {
  dynamic status;
  dynamic errNum;
  dynamic msg;

  ResetPasswordModel({this.status, this.errNum, this.msg});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }
}
