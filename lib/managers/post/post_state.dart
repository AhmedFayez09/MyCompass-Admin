part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}
final class GetAllPostsLoading extends PostState {}
final class GetAllPostsSuccess extends PostState {}
final class GetAllPostsFailure extends PostState {
  final ErrorModel errorModel;
  GetAllPostsFailure({required this.errorModel});
}
final class DeleteAllPostsLoading extends PostState {}
final class DeleteAllPostsSuccess extends PostState {}
final class DeleteAllPostsFailure extends PostState {
  final ErrorModel errorModel;
  DeleteAllPostsFailure({required this.errorModel});
}

final class DeletePostLoading extends PostState {}
final class DeletePostSuccess extends PostState {}
final class DeletePostFailure extends PostState {
  final ErrorModel errorModel;
  DeletePostFailure({required this.errorModel});
}

final class AddPostLoading extends PostState {}
final class AddPostSuccess extends PostState {}
final class AddPostFailure extends PostState {
  final ErrorModel errorModel;
  AddPostFailure({required this.errorModel});
}
final class UpdatePostLoading extends PostState {}
final class UpdatePostSuccess extends PostState {}
final class UpdatePostFailure extends PostState {
  final ErrorModel errorModel;
  UpdatePostFailure({required this.errorModel});
}


// comment
final class AddCommentLoading extends PostState {}
final class AddCommentSuccess extends PostState {}
final class AddCommentFailure extends PostState {
  final ErrorModel errorModel;
  AddCommentFailure({required this.errorModel});
}

final class GetCommentLoading extends PostState {}
final class GetCommentSuccess extends PostState {}
final class GetCommentFailure extends PostState {
  final ErrorModel errorModel;
  GetCommentFailure({required this.errorModel});
}



final class AddReplayLoading extends PostState {}
final class AddReplaySuccess extends PostState {}
final class AddReplayFailure extends PostState {
  final ErrorModel errorModel;
  AddReplayFailure({required this.errorModel});
}
final class AddPostLikeLoading extends PostState {}
final class AddPostLikeSuccess extends PostState {}
final class AddPostLikeFailure extends PostState {
  final ErrorModel errorModel;
  AddPostLikeFailure({required this.errorModel});
}
final class AddPostUnLikeLoading extends PostState {}
final class AddPostUnLikeSuccess extends PostState {}
final class AddPostUnLikeFailure extends PostState {
  final ErrorModel errorModel;
  AddPostUnLikeFailure({required this.errorModel});
}
