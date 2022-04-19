part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetUserProfileEvent extends ProfileEvent {
  
}
class GetOtherUserProfileEvent extends ProfileEvent {
  final String uid;
  GetOtherUserProfileEvent({required this.uid});
}