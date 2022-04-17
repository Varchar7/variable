import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:variable/model/solution.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.importance,
    required this.views,
    required this.uid,
    required this.time,
    required this.status,
    required this.solutions,
    required this.images,
  });

  String id;
  String title;
  String body;
  int importance;
  int views;
  Timestamp time;
  String status;
  String uid;
  List<Solution> solutions;
  String images;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        importance: json["importance"],
        views: json["views"],
        time: json["time"],
        status: json["status"],
        uid: json["uid"],
        images: json["images"],
        solutions: List<Solution>.from(
            json["solutions"].map((x) => Solution.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "importance": importance,
        "views": views,
        "time": time,
        "uid": uid,
        "status": status,
        "images": images,
        "solutions": List<dynamic>.from(solutions.map((x) => x.toJson())),
      };
}
