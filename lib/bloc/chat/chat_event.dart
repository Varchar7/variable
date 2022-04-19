part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {}

class DeleteMessageEvent extends ChatEvent {}

class ChatStatusEvent extends ChatEvent {
  final AppUser user;
  ChatStatusEvent({required this.user});
}
