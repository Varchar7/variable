import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:variable/feed/posts_builder.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/user_service.dart';

import '../bloc/profile/profile_bloc.dart';
import '../service/Firebase/curd_user_database.dart';
import '../widget/style.dart';
import 'edit_profile.dart';

class OtherUser extends StatefulWidget {
  const OtherUser({Key? key}) : super(key: key);

  @override
  _OtherUserState createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is! UserProfileState) {
              return Center(
                child: Lottie.asset(
                  'assets/init-animation.json',
                  alignment: Alignment.center,
                ),
              );
            } else {
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
                        '${state.appUser.username} Profile',
                        style: const TextStyle(
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
                                backgroundImage: state.appUser.image != ''
                                    ? NetworkImage(state.appUser.image)
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
                                        context, state.appUser.image);
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      GetUserProfileEvent(),
                                    );
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
                    '@' + state.appUser.username,
                    style: style().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 2,
                  ),
                  Text(
                    state.appUser.email,
                    style: style().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.75,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (state.appUser.followers
                          .contains(FirebaseAuthenticationService.user.uid)) {
                        await FirebaseDatabaseCollection.unFollowUser(
                            state.appUser.uid);
                        state.appUser.followers.remove(state.appUser.uid);
                      } else {
                        await FirebaseDatabaseCollection.followUser(
                            state.appUser.uid);
                        state.appUser.followers.add(state.appUser.uid);
                      }

                      BlocProvider.of<ProfileBloc>(context).add(
                          GetOtherUserProfileEvent(appUser: state.appUser));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.greenAccent,
                    ),
                    child: Text(
                      state.appUser.followings
                              .contains(FirebaseAuthenticationService.user.uid)
                          ? "Unfollow"
                          : 'Follow',
                      style: style(),
                    ),
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
                          state.appUser.posts.length,
                          state.appUser.followings.length,
                          state.appUser.followers.length,
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
                      '${state.appUser.username}\'s Posts',
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
                    querySnapshot:
                        UsersServices.getOtherUsersPost(state.appUser.uid),
                    isUserPost: false,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
