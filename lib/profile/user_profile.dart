import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:variable/service/Firebase/user_service.dart';

import '../model/user.dart';
import '../service/Firebase/curd_user_database.dart';
import '../widget/style.dart';
import 'edit_profile.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({Key? key}) : super(key: key);

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  AppUser? userDetails;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    Map<String, dynamic> json =
        await FirebaseDatabaseCollection.selectDataOnUserDatabase();
    userDetails = AppUser.fromJson(json);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: userDetails == null
            ? Center(
                child: Lottie.asset(
                  'assets/init-animation.json',
                  alignment: Alignment.center,
                ),
              )
            : ListView(
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
                      const Text(
                        'Your Profile',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: 'profile',
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: userDetails!.image != ''
                                    ? NetworkImage(userDetails!.image)
                                    : null,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: IconButton(
                                  onPressed: () async {
                                    await showMyBottomSheet(
                                        context, userDetails!.image);
                                    getUser();
                                  },
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 17.5,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    '@' + userDetails!.username,
                    style: style().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 2,
                  ),
                  Text(
                    userDetails!.email,
                    style: style().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.75,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0375,
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
                          userDetails!.posts.length,
                          userDetails!.followings.length,
                          userDetails!.followers.length,
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
                    height: MediaQuery.of(context).size.height * 0.0375,
                  ),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: const [],
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UsersServices.getUsersPost();
        },
      ),
    );
  }
}

class UserField {
  String title;
  String value;
  UserField({required this.title, required this.value});
}
