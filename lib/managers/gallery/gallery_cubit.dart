import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/gallery_model.dart';
export 'package:dio/dio.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  static GalleryCubit of(context) => BlocProvider.of<GalleryCubit>(context);

  DioHelper dioHelper = DioHelper();
  GalleryModel? galleryModel;

  void getAllGallery() async {
    emit(GetAllGalleryLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllGalleryUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        galleryModel = GalleryModel.fromJson(response.data);
        emit(GetAllGallerySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(GetAllGalleryFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void addGallery({
    required String galleryTitle,
    required String galleryDescription,
    List<String>? galleryImages,
    List<Uint8List?>? webImages, // For web platforms (multiple images)
  }) async {
    emit(AddGalleryLoading());
    // List<MultipartFile> imageFiles = [];
    //
    // if (galleryImages != null) {
    //   for (int i = 0; i < galleryImages.length; i++) {
    //     MultipartFile image = await MultipartFile.fromFile(
    //       galleryImages[i],
    //       filename: 'image$i',
    //     );
    //     imageFiles.add(image);
    //   }
    // }
    try {
      // Convert file paths to MultipartFile
      List<MultipartFile> imageFiles = [];
      if (galleryImages != null) {
        for (int i = 0; i < galleryImages.length; i++) {
          MultipartFile image = await MultipartFile.fromFile(
            galleryImages[i],
            filename: 'image$i.jpg', // Adjust filename as needed
          );
          imageFiles.add(image);
        }
      }
      List<MultipartFile> imagesFilesInWeb = [];

      if (webImages != null) {
        for (int i = 0; i < webImages.length; i++) {
          MultipartFile image = MultipartFile.fromBytes(
            webImages[i]!,
            filename: 'web_image_$i.jpg',
            contentType: MediaType('image', 'jpeg'), // MIME type
          );
          imagesFilesInWeb.add(image);
        }
      }

      // Prepare FormData
      print("l in function ${webImages?.length}");
      FormData formData = FormData.fromMap({
        "galleryTitle": galleryTitle,
        "galleryDescription": galleryDescription,
        if (galleryImages != null && imageFiles.isNotEmpty)
          "galleryImages": imageFiles,
        if (webImages != null && imagesFilesInWeb.isNotEmpty)
          "galleryImages": imagesFilesInWeb,
      });

      final response = await dioHelper.postData(
          endPoint: ApiConstants.addGalleryUrl, body: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        logWarning(response.data.toString());
        // galleryModel = GalleryModel.fromJson(response.data);
        emit(AddGallerySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddGalleryFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddGalleryFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(AddGalleryFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updateGallery({
    required String id,
    required String galleryTitle,
    required String galleryDescription,
    List<String>? galleryImages,
    List<Uint8List?>? webImages,
  }) async {

    emit(UpdateGalleryLoading());
    try {

      List<MultipartFile> imageFiles = [];
      if (galleryImages != null) {
        for (int i = 0; i < galleryImages.length; i++) {
          MultipartFile image = await MultipartFile.fromFile(
            galleryImages[i],
            filename: 'image$i.jpg', // Adjust filename as needed
          );
          imageFiles.add(image);
        }
      }
      List<MultipartFile> imagesFilesInWeb = [];

      if (webImages != null) {
        for (int i = 0; i < webImages.length; i++) {
          MultipartFile image = MultipartFile.fromBytes(
            webImages[i]!,
            filename: 'web_image_$i.jpg',
            contentType: MediaType('image', 'jpeg'), // MIME type
          );
          imagesFilesInWeb.add(image);
        }
      }

      FormData formData = FormData.fromMap({
        "galleryTitle": galleryTitle,
        "galleryDescription": galleryDescription,
        if (galleryImages != null && imageFiles.isNotEmpty)
          "galleryImages": imageFiles,
        if (webImages != null && imagesFilesInWeb.isNotEmpty)
          "galleryImages": imagesFilesInWeb,
      });

      final response = await dioHelper.patchData(
          endPoint: ApiConstants.updateGalleryUrl(id: id), body: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        logWarning(response.data.toString());
        emit(UpdateGallerySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(UpdateGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(UpdateGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      emit(UpdateGalleryFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteGallery({required String id}) async {
    emit(DeleteGalleryLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deleteGalleryUrl(id: id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteGallerySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteGalleryFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteAllGallery() async {
    emit(DeleteAllGalleryLoading());
    try {
      final response = await dioHelper.deleteData(
        endPoint: ApiConstants.deleteAllGalleriesUrl,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteAllGallerySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteAllGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteAllGalleryFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteAllGalleryFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }
}
