// getSoluions

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variable/bloc/profile/profile_bloc.dart';
import 'package:variable/model/user.dart';
import 'package:variable/profile/other_profile.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';
import 'package:variable/widget/style.dart';

class UsersBuilder extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>> querySnapshot;
  const UsersBuilder({
    Key? key,
    required this.querySnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: querySnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: style(),
            textAlign: TextAlign.center,
            textScaleFactor: 2,
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.active) {
              List<Map<String, dynamic>> rawUsers = [];
              for (var element in (snapshot.data as QuerySnapshot).docs) {
                rawUsers.add(element.data() as Map<String, dynamic>);
              }
              List<AppUser> users =
                  rawUsers.map((e) => AppUser.fromJson(e)).toList();
              users.removeWhere(
                (element) =>
                    element.uid == FirebaseAuthenticationService.user.uid,
              );
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: const StadiumBorder(),
                    elevation: 3,
                    child: ListTile(
                      tileColor: Colors.transparent,
                      onTap: () {
                        BlocProvider.of<ProfileBloc>(context).add(
                          GetOtherUserProfileEvent(
                            appUser: users[index],
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtherUser(),
                          ),
                        );
                      },
                      trailing: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is UserProfileState) {
                            return ElevatedButton(
                              onPressed: () {
                                if (state.appUser.followings
                                    .contains(users[index].uid)) {
                                  FirebaseDatabaseCollection.unFollowUser(
                                      users[index].uid);
                                } else {
                                  FirebaseDatabaseCollection.followUser(
                                      users[index].uid);
                                }
                                BlocProvider.of<ProfileBloc>(context)
                                    .add(GetUserProfileEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                primary: Colors.greenAccent,
                              ),
                              child: Text(
                                state.appUser.followings
                                        .contains(users[index].uid)
                                    ? "Unfollow"
                                    : 'Follow',
                                style: style(),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      leading: CircleAvatar(
                        backgroundColor: users[index].image.isEmpty
                            ? Colors.greenAccent
                            : null,
                        backgroundImage: users[index].image.isEmpty
                            ? null
                            : NetworkImage(users[index].image),
                      ),
                      title: Text(
                        users[index].username,
                        style: style(),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            );
          }
        }
      },
    );
  }
}
