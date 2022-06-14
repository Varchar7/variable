import 'package:flutter/material.dart';
import 'package:variable/search/users_builder.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/style.dart';

import '../../service/Firebase/curd_user_database.dart';

class Followers extends StatelessWidget {
  final List<String> followers;
  const Followers({Key? key, required this.followers}) : super(key: key);
  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
              const Text(
                'Your Followers',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 30,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: followers.isEmpty
                ? Center(
                    child: Text(
                      "not follows anyone",
                      style: style(),
                    ),
                  )
                : UsersBuilder(
                    querySnapshot: UsersServices.getOtherUsers(
                      followers,
                    ),
                    builder: (followers) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: followers.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: const StadiumBorder(),
                            child: ListTile(
                              tileColor: Colors.transparent,
                              title: Text(
                                followers[index].username,
                                style: style(),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () async {
                                  if (followers.contains(
                                    followers[index].uid,
                                  )) {
                                    await FirebaseDatabaseCollection
                                        .unFollowUser(followers[index].uid);
                                  } else {
                                    await FirebaseDatabaseCollection.followUser(
                                        followers[index].uid);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Colors.greenAccent,
                                ),
                                child: Text(
                                  followers.contains(
                                    followers[index].uid,
                                  )
                                      ? "Unfollow"
                                      : "Follow",
                                  style: style(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      )),
    );
  }
}
