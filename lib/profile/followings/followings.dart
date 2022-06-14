import 'package:flutter/material.dart';
import 'package:variable/search/users_builder.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';
import 'package:variable/service/Firebase/user_service.dart';

import 'package:variable/widget/style.dart';

class Followings extends StatelessWidget {
  final List<String> followings;
  const Followings({Key? key, required this.followings}) : super(key: key);
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
                  'Your Followings',
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
              child: followings.isEmpty
                  ? Center(
                      child: Text(
                        "not follows anyone",
                        style: style(),
                      ),
                    )
                  : UsersBuilder(
                      querySnapshot: UsersServices.getOtherUsers(
                        followings,
                      ),
                      builder: (followings) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: followings.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: const StadiumBorder(),
                              child: ListTile(
                                tileColor: Colors.transparent,
                                title: Text(
                                  followings[index].username,
                                  style: style(),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () async {
                                    if (followings.contains(
                                      followings[index].uid,
                                    )) {
                                      await FirebaseDatabaseCollection
                                          .unFollowUser(followings[index].uid);
                                    } else {
                                      await FirebaseDatabaseCollection
                                          .followUser(followings[index].uid);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    primary: Colors.greenAccent,
                                  ),
                                  child: Text(
                                    followings.contains(
                                      followings[index].uid,
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
        ),
      ),
    );
  }
}
