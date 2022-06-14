part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class UploadingState extends PostState {}

class SavedState extends PostState {}

class PostDeletingState extends PostState {}

class PostDeletedState extends PostState {}

class SolutionPostingState extends PostState {}

class SolutionPostedState extends PostState {}

class GetSolutionsState extends PostState {}
