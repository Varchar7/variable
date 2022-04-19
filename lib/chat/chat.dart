import 'package:flutter/material.dart';
import 'package:variable/chat/inchat.dart';
import 'package:variable/widget/textformfield.dart';

class Users {
  String username;
  Users({required this.username});
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // shared()async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setStringList('users', users)
  // }
  TextEditingController username = TextEditingController();
  List<Users> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0125,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Text(
                    'Chat',
                    style: TextStyle(
                      fontFamily: 'actor',
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      //DCE8FF
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        suffixIcon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Color(0xff89A2CB),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 25),
                  itemCount: users.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InTheChat(
                              username: users[index].username,
                            ),
                          ),
                        ); */
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2.5, 2.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        users[index].username,
                                        style: const TextStyle(
                                          fontFamily: 'actor',
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'the typed messages',
                                        style: TextStyle(
                                          fontFamily: 'actor',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMenu(
            elevation: 10,
            context: context,
            position: RelativeRect.fromLTRB(
              MediaQuery.of(context).size.width * 0.2,
              MediaQuery.of(context).size.height * 0.375,
              MediaQuery.of(context).size.width * 0.2,
              MediaQuery.of(context).size.height * 0.375,
            ),
            items: [
              PopupMenuItem(
                child: Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: username,
                        title: 'Username',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            users.add(
                              Users(
                                username: username.text,
                              ),
                            );
                          },
                        );
                        username.clear();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
