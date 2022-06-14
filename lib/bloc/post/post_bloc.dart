import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:variable/model/post.dart';
import 'package:variable/model/solution.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostEvent>(
      (event, emit) async {
        if (event is CreatePostEvent) {
          emit(UploadingState());
          FirebaseDatabaseCollection.createPostDatabase(
            {
              "title": event.post.title,
              "body": event.post.body,
              "importance": event.post.importance,
              "views": event.post.views,
              "time": event.post.time,
              "uid": event.post.uid,
              "favourites": event.post.favourites,
              "status": event.post.status,
              "solutions": event.post.solutions,
            },
            event.postImage,
          );
          emit(SavedState());
        } else if (event is DeletePostEvent) {
          emit(PostDeletingState());
          await FirebaseDatabaseCollection.deletePostDatabase(
            event.postID,
            event.haveImage,
          );
          emit(PostDeletedState());
        } else if (event is SolutionPostEvent) {
          emit(SolutionPostingState());
          await FirebaseDatabaseCollection.createSoluton(
              event.solution.toJson());
          emit(SolutionPostedState());
        }
      },
    );
  }
}
