import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:variable/model/user.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is GetUserProfileEvent) {
          Map<String, dynamic> json =
              await FirebaseDatabaseCollection.selectDataOnUserDatabase();
          AppUser appUser = AppUser.fromJson(json);
          emit(
            UserProfileState(
              appUser: appUser,
            ),
          );
        } else if (event is GetOtherUserProfileEvent) {
          emit(
            OtherProfileState(
              uid: event.uid,
            ),
          );
        }
      },
    );
  }
}
