part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatMessageState extends ChatState {}

class CreateCoupleLoadingState extends ChatState {}

class CreatedCoupleState extends ChatState {
final   String chatID;
  CreatedCoupleState({required this.chatID});
}
