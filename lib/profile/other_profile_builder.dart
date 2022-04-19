import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/chat/inchat.dart';
import 'package:variable/feed/posts_builder.dart';
import 'package:variable/model/message.dart';
import 'package:variable/model/user.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/style.dart';
import 'package:intl/intl.dart';

import '../bloc/chat/chat_bloc.dart';

class IndividualUserBuilder extends StatelessWidget {
  final Stream<DocumentSnapshot<Object?>> querySnapshot;
  const IndividualUserBuilder({
    Key? key,
    required this.querySnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: querySnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: style(),
            textAlign: TextAlign.center,
            textScaleFactor: 2,
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map<String, dynamic> response =
                  (snapshot.data as DocumentSnapshot).data()
                      as Map<String, dynamic>;
              AppUser appUser = AppUser.fromJson(response);
              return ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${appUser.username} Profile',
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'profile',
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: appUser.image != ''
                            ? NetworkImage(appUser.image)
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    '@' + appUser.username,
                    style: style().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 2,
                  ),
                  Text(
                    appUser.email,
                    style: style().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.75,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (appUser.followers.contains(
                              FirebaseAuthenticationService.user.uid)) {
                            await FirebaseDatabaseCollection.unFollowUser(
                                appUser.uid);
                          } else {
                            await FirebaseDatabaseCollection.followUser(
                                appUser.uid);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.greenAccent,
                        ),
                        child: Text(
                          appUser.followers.contains(
                                  FirebaseAuthenticationService.user.uid)
                              ? "Unfollow"
                              : "Follow",
                          style: style(),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ChatBloc>(context).add(
                            ChatStatusEvent(
                              user: appUser,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserChatPage(
                                couple: appUser,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.greenAccent,
                        ),
                        child: Text(
                          "Message",
                          style: style(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  Table(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      TableRow(
                        children: [
                          "Post",
                          "Following",
                          "Followers",
                        ]
                            .map(
                              (e) => Text(
                                e,
                                textScaleFactor: 1.75,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  decorationThickness: 2,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      TableRow(
                        children: [
                          appUser.posts.length,
                          appUser.followings.length,
                          appUser.followers.length,
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$e',
                                  textScaleFactor: 1.5,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${appUser.username}\'s Posts',
                      textScaleFactor: 1.25,
                      style: const TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  PostsBuilder(
                    querySnapshot: UsersServices.getOtherUserPost(appUser.uid),
                    isUserPost: false,
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightGreen,
              ),
            );
          }
        }
      },
    );
  }

  Widget messageBuilder(List<ChatMessage> messages, int index) {
    return GestureDetector(
      child: Align(
        alignment: messages[index].uid == FirebaseAuthenticationService.user.uid
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(
            top: 7,
            bottom: 7,
            left: messages[index].uid == FirebaseAuthenticationService.user.uid
                ? 25
                : 7.5,
            right: messages[index].uid == FirebaseAuthenticationService.user.uid
                ? 7.5
                : 25,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: messages[index].uid ==
                        FirebaseAuthenticationService.user.uid
                    ? Colors.greenAccent[400]
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft: messages[index].uid ==
                          FirebaseAuthenticationService.user.uid
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  bottomRight: messages[index].uid ==
                          FirebaseAuthenticationService.user.uid
                      ? const Radius.circular(0)
                      : const Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: messages[index].uid ==
                            FirebaseAuthenticationService.user.uid
                        ? const Offset(3, 3)
                        : const Offset(-3, 3),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Wrap(
                crossAxisAlignment: messages[index].uid ==
                        FirebaseAuthenticationService.user.uid
                    ? WrapCrossAlignment.end
                    : WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                direction: Axis.vertical,
                children: [
                  Text(
                    messages[index].message,
                    style: style().copyWith(
                      fontSize: messages[index].size,
                    ),
                    /* TextStyle(
                                      fontSize: messages[index].size,
                                      color: index == selectedIndex ||
                                              messages[index].messager
                                          ? Colors.white
                                          : Colors.black,
                                    ), */
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    getMessageTime(messages[index].time.toDate()),
                    style: style().copyWith(fontSize: messages[index].size / 2),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getMessageTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MMM-yyyy h:m');
    return formatter.format(dateTime);
  }
}
