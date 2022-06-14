import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:variable/search/search_users.dart';
import 'package:variable/user_problem/problem.dart';

import '../feed/feed.dart';
import '../profile/user_profile.dart';

class PageManager extends StatefulWidget {
  const PageManager({Key? key}) : super(key: key);

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        ShowFeed(),
        IssueScreen(),
        SearchUsers(),
        ShowProfile(),
      ],
    );
  }
}
