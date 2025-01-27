import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/post_model.dart';
import 'package:flutter/foundation.dart';

import '../../core/dio/dio_helper.dart';
import '../../models/comment_model.dart';
import '../admin_cubit.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  static AdminCubit of(context) => BlocProvider.of<AdminCubit>(context);

  DioHelper dioHelper = DioHelper();

  PostsModel? postsModel;

  void getAllPosts() async {
    emit(GetAllPostsLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getPostsUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        postsModel = PostsModel.fromJson(response.data);

        emit(GetAllPostsSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllPostsFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllPostsFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(GetAllPostsFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void addPost({
    required String title,
    required String description,
    File? image,
    Uint8List? webImage, // For web platforms
  }) async {
    emit(AddPostLoading());
    try {
      FormData formData = FormData.fromMap({
        'postTitle': title,
        'postContent': description,
        if (image != null) // For non-web platforms
          'postImage': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        if (webImage != null) // For web platforms
          'postImage': MultipartFile.fromBytes(
            webImage,
            filename: 'web_image.jpg', // Provide a default name
            contentType: MediaType('image', 'jpeg'), // MIME type
          ),
      });

      final response = await dioHelper.postData(
        endPoint: ApiConstants.addPostUrl,
        body: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddPostSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddPostFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddPostFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(AddPostFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updatePost({
    required String postId,
    String? title,
    String? description,
    File? image,
    Uint8List? webImage, // For web platforms
  }) async {
    emit(UpdatePostLoading());
    try {
      FormData formData = FormData.fromMap({
        if (title != null) 'postTitle': title,
        if (description != null) 'postContent': description,
        if (image != null) // For non-web platforms
          'postImage': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        if (webImage != null) // For web platforms
          'postImage': MultipartFile.fromBytes(
            webImage,
            filename: 'web_image.jpg', // Provide a default name
            contentType: MediaType('image', 'jpeg'), // MIME type
          ),
      });

      final response = await dioHelper.patchData(
        endPoint: ApiConstants.updatePostUrl(id: postId),
        body: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdatePostSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(UpdatePostFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(UpdatePostFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(UpdatePostFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deletePost({required String postId}) async {
    emit(DeletePostLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deletePostUrl(id: postId));
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeletePostSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeletePostFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeletePostFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(DeletePostFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  // comment

  void addComment({required String postId, required String comment}) async {
    emit(AddCommentLoading());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.addCommentUrl(id: postId),
        body: {'commentContent': comment},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddCommentSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddCommentFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddCommentFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(AddCommentFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  // replay
  void addReplay({required String id, required String replay}) async {
    emit(AddReplayLoading());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.addReplyUrl(id: id),
        body: {'commentContent': replay},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddReplaySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddReplayFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddReplayFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(AddReplayFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

 void addPostLike({
    required String postId,
  }) async {
    emit(AddPostLikeLoading());
    try {
      final response = await dioHelper.patchData(
        endPoint: ApiConstants.addPostLikeUrl(id: postId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddPostLikeSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddPostLikeFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddPostLikeFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(AddPostLikeFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }



  void addPostUnLike({
    required String postId,
  }) async {
    emit(AddPostUnLikeLoading());
    try {
      final response = await dioHelper.patchData(
        endPoint: ApiConstants.addPostUnLikeUrl(id: postId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddPostUnLikeSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddPostUnLikeFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddPostUnLikeFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(AddPostUnLikeFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }



  CommentModel? commentModel;

  void getComment({required String postId}) async {
    emit(GetCommentLoading());
    try {
      final response = await dioHelper.getData(
        endPoint: ApiConstants.getCommentsUrl(id: postId),

      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        commentModel = CommentModel.fromJson(response.data);
        emit(GetCommentSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetCommentFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetCommentFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(GetCommentFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }









}
