import 'package:cloud_firestore/cloud_firestore.dart';

class Solution {
  Solution({
    required this.uid,
    required this.solution,
    required this.like,
    required this.postID,
    required this.view,
    required this.upvote,
    required this.downgrade,
    required this.time,
  });

  String uid;
  String postID;
  String solution;
  int like;
  int view;
  int upvote;
  int downgrade;
  Timestamp time;

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
        uid: json["uid"],
        like: json["like"],
        view: json["view"],
        postID:json["postID"],
        solution: json["solution"],
        upvote: json["upvote"],
        downgrade: json["downgrade"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "solution": solution,
        "like": like,
        "postID":postID,
        "view": view,
        "upvote": upvote,
        "downgrade": downgrade,
        "time": time,
      };
}
