class RoomModel {
  String roomId;
  String lastSenderId;
  String lastMsgUpdate;
  bool isActive;
  String userImage;
  RoomModel(
      {this.roomId,
      this.userImage,
      this.lastMsgUpdate,
      this.lastSenderId,
      this.isActive});

  RoomModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    userImage = json['user_image'];
    lastMsgUpdate = json['last_msg_update'];
    lastSenderId = json['last_sender_id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['user_image'] = this.userImage;
    data['last_msg_update'] = this.lastMsgUpdate;
    data['last_sender_id'] = this.lastSenderId;
    data['is_active'] = this.isActive;
    return data;
  }
}
