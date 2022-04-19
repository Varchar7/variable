import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:variable/model/message.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';
import 'package:variable/widget/style.dart';
import 'package:intl/intl.dart';

class MessagesBuilder extends StatelessWidget {
  final Stream<DocumentSnapshot<Object?>> querySnapshot;
  final ScrollController scrollController;
  final String coupleID;
  const MessagesBuilder({
    Key? key,
    required this.scrollController,
    required this.querySnapshot,
    required this.coupleID,
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
              List<ChatMessage> messages = List<ChatMessage>.from(
                response["messages"].map(
                  (x) => ChatMessage.fromJson(x),
                ),
              );
              return ListView.builder(
                padding: const EdgeInsets.only(
                    left: 12.5, right: 12.5, top: 5, bottom: 5),
                itemCount: messages.length,
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemBuilder: (context, int index) {
                  return messages[index].uid == coupleID
                      ? messageBuilder(messages, index)
                      : Dismissible(
                          key: ValueKey<String>(messages[index].message),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            FirebaseDatabaseCollection.deleteMessage(
                              messages[index].id,
                              messages[index].toJson(),
                            );
                          },
                          child: messageBuilder(messages, index),
                        );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
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
                    softWrap: true,
                    overflow: TextOverflow.fade,
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
