import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:safsofa/shared/constants.dart';

class ChatScreen extends StatefulWidget {
  final int techSupportId;
  final String type; //for room type

  const ChatScreen({Key key, @required this.techSupportId, @required this.type})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  String roomId = '';

  @override
  void initState() {
    checkRoomExistence(
      senderId: CacheHelper.getData('id'),
      receiverId: widget.techSupportId,
      userImage: '',
    );
    super.initState();
  }

  checkRoomExistence(
      {@required int senderId,
      @required int receiverId,
      @required String userImage}) async {
    log('checking room function');
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    roomId = receiverId > senderId
        ? "$receiverId,$senderId"
        : "$senderId,$receiverId";
    final snapshot = await rooms.where('room_id', isEqualTo: roomId).get();
    log('Result of checking room existence');
    log('${snapshot.docs.length}');
    log('*' * 50);
    if (snapshot.docs.isEmpty) {
      log('No Rooms with this Id was found');
      createChatRoom(
          senderId: senderId,
          receiverId: receiverId,
          userImage: userImage,
          roomType: widget.type);
    } else {
      updateRoomOnStart(roomId: roomId, userImage: '');
    }
  }

  void createChatRoom(
      {@required int senderId,
      @required int receiverId,
      @required String userImage,
      @required String roomType}) async {
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    await rooms.add({
      "room_id": receiverId > senderId
          ? "$receiverId,$senderId"
          : "$senderId,$receiverId",
      "user_image": userImage,
      "last_msg_update": "",
      "last_sender_id": "",
      "is_active": true,
      "agent_type": roomType,
    });
  }

  sendMessage(
      {@required String text,
      @required String roomId,
      @required String senderId}) async {
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
    await messages.add({
      "room_id": roomId,
      "send_receive_id": senderId,
      "text": text,
      "time": Timestamp.fromDate(DateTime.now()),
    });
  }

  updateRoomBeforeClose(
      {@required String roomId, @required String userImage}) async {
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
    final snapShot =
        await messages.orderBy('time', descending: true).limit(1).get();
    Map<String, dynamic> messageData = snapShot.docs[0].data();
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    final room = await rooms.where('room_id', isEqualTo: roomId).get();
    await rooms.doc(room.docs[0].id).update({
      "user_image": userImage,
      "last_msg_update": messageData['text'],
      "last_sender_id": messageData['send_receive_id'],
      "is_active": false,
    });
  }

  updateRoomOnStart(
      {@required String roomId, @required String userImage}) async {
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    final room = await rooms.where('room_id', isEqualTo: roomId).get();
    await rooms.doc(room.docs[0].id).update({
      "user_image": userImage,
      "is_active": true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chats'.tr(),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 8, top: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('messages')
              .where(
                'room_id',
                isEqualTo: /*'130,9'*/ /*ChatCubit.get(context).*/ roomId,
              )
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: snapShot.data.docs[index]
                                    .data()['send_receive_id'] ==
                                CacheHelper.getData('id').toString()
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: snapShot.data.docs[index]
                                        .data()['send_receive_id'] ==
                                    CacheHelper.getData('id').toString()
                                ? WrapCrossAlignment.start
                                : WrapCrossAlignment.end,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                decoration: BoxDecoration(
                                    color: snapShot.data.docs[index]
                                                .data()['send_receive_id'] ==
                                            CacheHelper.getData('id').toString()
                                        ? Colors.green.shade300
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    '${snapShot.data.docs[index].data()['text']}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                              Text(
                                '${DateFormat.yMd().add_jm().format(snapShot.data.docs[index].data()['time'].toDate())}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                      itemCount: snapShot.data.docs.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: "typeYourMessage".tr(),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // ChatCubit.get(context)
                            //     .updateRoomBeforeClose(roomId: '130,9');
                            if (messageController.text.trim().isNotEmpty) {
                              setState(() {
                                /*ChatCubit.get(context).*/ sendMessage(
                                  text: messageController.text,
                                  roomId: /*ChatCubit.get(context).*/ roomId,
                                  senderId:
                                      CacheHelper.getData('id').toString(),
                                );
                                messageController.clear();
                              });
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: kDarkGoldColor,
                            child: Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    updateRoomBeforeClose(roomId: roomId, userImage: '');
    super.dispose();
  }
}
