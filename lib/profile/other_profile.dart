import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:variable/profile/other_profile_builder.dart';
import 'package:variable/service/Firebase/user_service.dart';

import '../bloc/profile/profile_bloc.dart';

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
            if (state is OtherProfileState) {
              return IndividualUserBuilder(
                querySnapshot: UsersServices.getIndividualUser(
                  state.uid,
                ),
              );
            } else {
              return Center(
                child: Lottie.asset(
                  'assets/init-animation.json',
                  alignment: Alignment.center,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
