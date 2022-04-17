part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class CreatePostEvent extends PostEvent {
  final Post post;
  final Uint8List? postImage;
  CreatePostEvent({required this.post, required this.postImage});
}

class DeletePostEvent extends PostEvent {
  final String postID;
  final bool haveImage;
  DeletePostEvent({required this.postID, required this.haveImage});
}
