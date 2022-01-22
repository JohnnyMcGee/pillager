import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String sender;
  DateTime timeStamp;
  String message;

  Comment(
      {required this.sender, required this.timeStamp, required this.message});

  Comment.fromMap(map)
      : sender = map["sender"] as String,
        timeStamp = map["timeStamp"].toDate(),
        message = map["message"] as String;

  Map<String, Object> toMap() => {
        "sender": sender,
        "timeStamp": timeStamp,
        "message": message,
      };
}
