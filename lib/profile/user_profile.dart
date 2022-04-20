import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:variable/feed/posts_builder.dart';
import 'package:variable/profile/followers/followers.dart';
import 'package:variable/profile/followings/followings.dart';
import 'package:variable/service/Firebase/user_service.dart';
import 'package:variable/widget/snackbar.dart';

import '../bloc/post/post_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../widget/style.dart';
import 'edit_profile.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({Key? key}) : super(key: key);

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(
      GetUserProfileEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostDeletedState) {
              popSnackbar(
                context: context,
                text: "Post deleted successfully",
              );
              BlocProvider.of<ProfileBloc>(context).add(
                GetUserProfileEvent(),
              );
            }
          },
        ),
      ],
      child: Scaffold(
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
                      height: MediaQuery.of(context).size.height * 0.0375,
                    ),
                    Table(
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        TableRow(
                          children: [
                            FieldBuilder(
                              title: "Post",
                              field: "${state.appUser.posts.length}",
                              callback: () {},
                            ),
                            FieldBuilder(
                              title: "Following",
                              field: "${state.appUser.followings.length}",
                              callback: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => Followings(
                                          followings: state.appUser.followings,
                                        )),
                                  ),
                                );
                              },
                            ),
                            FieldBuilder(
                              title: "Followers",
                              field: "${state.appUser.followers.length}",
                              callback: () {
                                // Followers
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => Followers(
                                          followers: state.appUser.followers,
                                        )),
                                  ),
                                );
                              },
                            ),
                          ]
                              .map(
                                (e) => InkWell(
                                  onTap: e.callback,
                                  child: Text(
                                    e.title + "\n" + e.field,
                                    textScaleFactor: 1.75,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      decorationThickness: 2,
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
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Your Posts',
                        textScaleFactor: 1.25,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0125,
                    ),
                    PostsBuilder(
                      querySnapshot: UsersServices.getUsersPost(),
                      isUserPost: true,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class FieldBuilder {
  String title;
  String field;
  VoidCallback callback;
  FieldBuilder(
      {required this.title, required this.field, required this.callback});
}
