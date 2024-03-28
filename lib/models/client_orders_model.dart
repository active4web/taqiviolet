import 'package:safsofa/models/my_orders_model.dart';

class ClintOrdersModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  ClintOrdersModel({this.status, this.errNum, this.msg, this.data});

  ClintOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<MyOrdersData>? all;
  List<MyOrdersData>? waiting;
  List<MyOrdersData>? done;
  List<MyOrdersData>? current;
  List<MyOrdersData>? hold;

  Data({this.all, this.waiting, this.done, this.current, this.hold});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['all'] != null) {
      all = <MyOrdersData>[];
      json['all'].forEach((v) {
        all!.add(new MyOrdersData.fromJson(v));
      });
    }
    if (json['waiting'] != null) {
      waiting = <MyOrdersData>[];
      json['waiting'].forEach((v) {
        waiting!.add(new MyOrdersData.fromJson(v));
      });
    }
    if (json['done'] != null) {
      done = <MyOrdersData>[];
      json['done'].forEach((v) {
        done!.add(new MyOrdersData.fromJson(v));
      });
    }
    if (json['current'] != null) {
      current = <MyOrdersData>[];
      json['current'].forEach((v) {
        current!.add(new MyOrdersData.fromJson(v));
      });
    }
    if (json['hold'] != null) {
      hold = <MyOrdersData>[];
      json['hold'].forEach((v) {
        hold!.add(new MyOrdersData.fromJson(v));
      });
    }
  }

}

