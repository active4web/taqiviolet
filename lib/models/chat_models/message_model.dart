import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String roomId;
  String senderReceiveId;
  String text;
  Timestamp time;
  MessageModel({this.roomId, this.senderReceiveId, this.text, this.time});
  MessageModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    senderReceiveId = json['send_receive_id'];
    text = json['text'];
    time = json['time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['send_receive_id'] = this.senderReceiveId;
    data['text'] = this.text;
    data['time'] = this.time;
    return data;
  }
}
