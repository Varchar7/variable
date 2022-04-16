

class Solution {
  Solution({
    required this.uid,
    required this.like,
    required this.view,
    required this.upvote,
    required this.downgrade,
    required this.time,
  });

  String uid;
  int like;
  int view;
  int upvote;
  int downgrade;
  String time;

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
        uid: json["uid"],
        like: json["like"],
        view: json["view"],
        upvote: json["upvote"],
        downgrade: json["downgrade"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "user": uid,
        "like": like,
        "view": view,
        "upvote": upvote,
        "downgrade": downgrade,
        "time": time,
      };
}
