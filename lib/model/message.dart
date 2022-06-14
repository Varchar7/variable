import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.message,
    required this.size,
    required this.uid,
    required this.time,
    required this.isFav,
  });
  String id;
  String message;
  double size;
  String uid;
  Timestamp time;
  bool isFav;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        message: json["message"],
        size: json["size"].toDouble(),
        uid: json["uid"],
        time: json["time"],
        isFav: json["isFav"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "size": size,
        "uid": uid,
        "time": time,
        "isFav": isFav,
      };
}
