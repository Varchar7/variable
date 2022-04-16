import 'package:flutter/material.dart';
import 'package:variable/profile/user_profile.dart';
import 'package:variable/user_problem/problem.dart';

import '../feed/feed.dart';

class PageManager extends StatefulWidget {
  const PageManager({Key? key}) : super(key: key);

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        const ShowFeed(),
        const IssueScreen(),
        Container(
          color: Colors.blue,
        ),
        const ShowProfile(),
      ],
    );
  }
}
