import 'package:flutter/material.dart';
import 'package:variable/auth/auth.dart';
import 'package:variable/auth/splash.dart';
import 'package:variable/feed/posts_builder.dart';
import 'package:variable/model/post.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/textformfield.dart';

import '../push_notification/service.dart';

class ShowFeed extends StatefulWidget {
  const ShowFeed({Key? key}) : super(key: key);

  @override
  State<ShowFeed> createState() => _ShowFeedState();
}

class _ShowFeedState extends State<ShowFeed> {
  bool isFavourite = false;
  TextEditingController search = TextEditingController();
  List<Post> posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 75.0,
              leading: IconButton(
                onPressed: () async {
                  await KeepUser.logOutUser();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const Splash()),
                    ),
                  );
                },
                color: Colors.black,
                icon: const Icon(
                  Icons.logout,
                ),
              ),
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  'Feed',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 1,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                    NotificationService.pushSimple();
                  },
                  color: Colors.green,
                  icon: const Icon(
                    Icons.notifications,
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  InputField(
                    title: "Search",
                    controller: search,
                    search: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  /*  const Text(
                    'Explore the your interest',
                    textScaleFactor: 1.25,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return const Chip(
                          label: Text('IT'),
                        );
                      },
                    ),
                  ), */
                  const Text(
                    'Explore interested feed',
                    textScaleFactor: 1.25,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  PostsBuilder(
                    querySnapshot: UsersServices.getAllPost(),
                    isUserPost: false,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
