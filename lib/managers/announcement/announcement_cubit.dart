import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/announcement_model.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';

import '../employees/employees_cubit.dart';
export 'package:dio/dio.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(AnnouncementInitial());

  static AnnouncementCubit of(context) =>
      BlocProvider.of<AnnouncementCubit>(context);

  DioHelper dioHelper = DioHelper();

  void addNewAnnouncement({
    required String title,
    required String description,
    required String priority,
    required String type,
    File? image, // Added parameter to receive image
    Uint8List? webImage, // For web platforms
  }) async {
    emit(AddNewAnnouncementLoading());
    try {
      String? mimeType;

      // Check MIME type if image is provided
      if (image != null) {
        mimeType = lookupMimeType(image.path);
        print("Image MIME Type: $mimeType");

        // Validate allowed image types (jpg, jpeg, png)
        if (mimeType == null ||
            !(mimeType == 'image/jpeg' || mimeType == 'image/png')) {
          throw Exception(
              "Invalid image type. Only JPG, JPEG, and PNG are allowed.");
        } else {
          print("Image MIME Type: $mimeType");
        }
      }

      // Create a multipart form data request
      FormData formData = FormData.fromMap({
        'announcementTitle': title,
        'announcementDesc': description,
        'Priority': priority,
        'type': type,
        if (image != null) // For non-web platforms
          'announcementAttach': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        if (webImage != null) // For web platforms
          'announcementAttach': MultipartFile.fromBytes(
            webImage,
            filename: 'web_image.jpg', // Provide a default name
            contentType: MediaType('image', 'jpeg'), // MIME type
          ),
      });
      final response = await dioHelper.postData(
        endPoint: ApiConstants.addAnnouncementUrl,
        body: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddNewAnnouncementSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddNewAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddNewAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(AddNewAnnouncementFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updateAnnouncement({
    required String id,
    required String title,
    required String description,
    required String priority,
    required String type,
    File? image, // Added parameter to receive image
    Uint8List? webImage, // For web platforms
  }) async {
    print(title);
    print(description);
    print("priority $priority");
    print("type $type");
    print(image);
    print(webImage);
    emit(UpdateAnnouncementLoading());
    try {
      // Create a multipart form data request
      FormData formData = FormData.fromMap({
        'announcementTitle': title,
        'announcementDesc': description,
        'Priority': priority,
        'type': type,
        if (image != null) // For non-web platforms
          'announcementAttach': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        if (webImage != null) // For web platforms
          'announcementAttach': MultipartFile.fromBytes(
            webImage,
            filename: 'web_image.jpg', // Provide a default name
            contentType: MediaType('image', 'jpeg'), // MIME type
          ),
      });
      final response = await dioHelper.patchData(
        endPoint: ApiConstants.updateAnnouncementUrl(id: id),
        body: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateAnnouncementSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(UpdateAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(UpdateAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(UpdateAnnouncementFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  AnnouncementModel? announcementModel;

  void getAllAnnouncements() async {
    emit(GetAllAnnouncementLoading());

    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllAnnouncementUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        announcementModel = AnnouncementModel.fromJson(response.data);
        emit(GetAllAnnouncementSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GetAllAnnouncementFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteAnnouncement({required String id}) async {
    emit(DeleteAnnouncementLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deleteSpAnnouncementUrl(id: id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteAnnouncementSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteAnnouncementFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteAllAnnouncements() async {
    emit(DeleteAllAnnouncementLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deleteAllAnnouncementsUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteAllAnnouncementSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteAllAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteAllAnnouncementFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteAllAnnouncementFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }
}
