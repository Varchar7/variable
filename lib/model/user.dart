import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser({
    required this.username,
    required this.email,
    required this.password,
    required this.mobile,
    required this.image,
    required this.uid,
    required this.posts,
    required this.messageToken,
    required this.followings,
    required this.followers,
    required this.points,
    required this.accuracy,
    required this.solutions,
    required this.favourite,
    required this.saved,
    required this.chat,
  });

  String username;
  String email;
  String password;
  String mobile;
  String image;
  String uid;
  String messageToken;
  List<String> posts;
  List<String> followings;
  List<String> followers;
  int points;
  int accuracy;
  List<String> favourite;
  List<String> solutions;
  List<String> saved;
  List<UserChat> chat;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        image: json["image"],
        uid: json["uid"],
        solutions: List<String>.from(json["solutions"].map((x) => x)),
        posts: List<String>.from(json["posts"].map((x) => x)),
        followings: List<String>.from(json["followings"].map((x) => x)),
        followers: List<String>.from(json["followers"].map((x) => x)),
        points: json["points"],
        messageToken: json["messageToken"],
        accuracy: json["accuracy"],
        favourite: List<String>.from(json["favourite"].map((x) => x)),
        saved: List<String>.from(json["saved"].map((x) => x)),
        chat:
            List<UserChat>.from(json["chat"].map((x) => UserChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "mobile": mobile,
        "image": image,
        "uid": uid,
        "messageToken": messageToken,
        "solutions": List<dynamic>.from(solutions.map((x) => x)),
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "followings": List<dynamic>.from(followings.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "points": points,
        "accuracy": accuracy,
        "favourite": List<dynamic>.from(favourite.map((x) => x)),
        "saved": List<dynamic>.from(saved.map((x) => x)),
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
      };
}

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  UserChat({
    required this.chatid,
    required this.couple,
  });

  String chatid;
  String couple;

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        chatid: json["chatid"],
        couple: json["couple"],
      );

  Map<String, dynamic> toJson() => {
        "chatid": chatid,
        "couple": couple,
      };
}
