part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {
  
}


class UserProfileState extends ProfileState {
  final AppUser appUser;
  UserProfileState({required this.appUser});
}

class OtherProfileState extends ProfileState {
  final String uid;
  OtherProfileState({required this.uid});
}

