import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/chat/message_builder.dart';
import 'package:variable/model/message.dart';
import 'package:variable/model/user.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/snackbar.dart';
import 'package:variable/widget/style.dart';
import 'package:variable/widget/textformfield.dart';

import '../bloc/chat/chat_bloc.dart';
import '../bloc/messages/messages_bloc.dart';

class UserChatPage extends StatefulWidget {
  final AppUser couple;
  const UserChatPage({Key? key, required this.couple}) : super(key: key);

  @override
  _UserChatPageState createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  String chatId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  widget.couple.image.isEmpty ? Colors.greenAccent : null,
              backgroundImage: widget.couple.image.isEmpty
                  ? null
                  : NetworkImage(
                      widget.couple.image,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.couple.username,
                  style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  ' ',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            iconSize: 25,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {},
                  child: Text(
                    'Show Profile',
                    style: style(),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: Text('Mute', style: style()),
                ),
                PopupMenuItem(
                  onTap: () {
                    message.clear();
                  },
                  child: Text('Clear Chat', style: style()),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<MessageSizeBloc, double>(
            builder: (context, state) {
              return Slider(
                value: state,
                min: 10,
                max: 40,
                thumbColor: Colors.greenAccent,
                activeColor: Colors.greenAccent,
                inactiveColor: Colors.greenAccent,
                onChanged: (number) {
                  BlocProvider.of<MessageSizeBloc>(context).add(number);
                },
              );
            },
          ),
          Expanded(
            child: Center(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is CreatedCoupleState) {
                    chatId = state.chatID;

                    return MessagesBuilder(
                      querySnapshot: UsersServices.getChats(
                        state.chatID,
                      ),
                      scrollController: scrollController,
                      coupleID: widget.couple.uid,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: InputField(
                  controller: message,
                  title: 'Type a Messages',
                ),
              ),
              BlocBuilder<MessageSizeBloc, double>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (message.text.isEmpty) {
                        popSnackbar(
                            context: context, text: "type the message");
                      } else {
                        await FirebaseDatabaseCollection.sendMessage(
                          chatId,
                          ChatMessage(
                            id: chatId,
                            isFav: false,
                            message: message.text,
                            size: state,
                            time: Timestamp.now(),
                            uid: FirebaseAuthenticationService.user.uid,
                          ).toJson(),
                        );
                        message.clear();
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 75);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.greenAccent,
                    ),
                    child: Text(
                      "Send",
                      style: style(),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}
