import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    required this.favourites,
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
  List<String> solutions;
  List<String> favourites;
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
        favourites: List<String>.from(
          json["favourites"].map(
            (x) => x,
          ),
        ),
        solutions: List<String>.from(
          json["solutions"].map(
            (x) => x,
          ),
        ),
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
        "favourites": List<String>.from(favourites.map((x) => x)),
        "solutions": List<String>.from(solutions.map((x) => x)),
      };
}
