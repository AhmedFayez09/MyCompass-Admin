import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/families_ids_model.dart';
import 'package:mycompass_admin_website/models/family_model.dart';
export 'package:dio/dio.dart';

part 'family_state.dart';

class FamilyCubit extends Cubit<FamilyState> {
  FamilyCubit() : super(FamilyInitial());

  static FamilyCubit of(context) => BlocProvider.of<FamilyCubit>(context);

  DioHelper dioHelper = DioHelper();

  void createNewFamily(
      {required String userName,
      required String email,
      required int noOfAppartment,
      required String password,
      required String cPassword,
      required String phone,
      required String memberType}) async {
    emit(CreateNewFamilyLoading());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.createNewFamilyUrl,
        body: {
          'userName': userName,
          'email': email,
          'noOfAppartment': noOfAppartment,
          "phone": phone,
          'password': password,
          'cPassword': cPassword,
          "memberType": memberType
        },
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateNewFamilySuccess(
          message: 'Family created successfully',
        ));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['Error']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(CreateNewFamilyFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else if (response.statusCode == 400) {
        emit(CreateNewFamilyFailure(
            errorModel:
                ErrorModel(message: response.data['message'].toString())));
      } else {
        final errorMessage =
            response.data['Error']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(CreateNewFamilyFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(CreateNewFamilyFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  FamilyModel? familyModel;

  void getAllFamilies() async {
    emit(GetAllFamiliesLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllFamiliesUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        familyModel = FamilyModel.fromJson(response.data);
        print("family data ${response.data}");
        emit(GetAllFamiliesSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllFamiliesFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllFamiliesFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(
          GetAllFamiliesFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteFamily({required String id}) async {
    emit(DeleteFamilyLoading());
    try {
      final response = await dioHelper.deleteData(
        endPoint: ApiConstants.deleteFamilyUrl(id: id),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteFamilySuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(
            DeleteFamilyFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(
            DeleteFamilyFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteFamilyFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updateFamily({
    required String id,
    String? userName,
    String? email,
    int? noOfAppartment,
    String? phone,
    String? memberType,
  }) async {
    print(memberType);
    emit(UpdateFamilyLoading());
    try {
      final response = await dioHelper.patchData(
        endPoint: ApiConstants.updateFamilyUrl(id: id),
        body: {
          if (userName != null) 'userName': userName,
          if (email != null) 'email': email,
          if (noOfAppartment != null) 'noOfAppartment': noOfAppartment,
          if (phone != null) "phone": phone,
          if (memberType != null) "memberType": memberType
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateFamilySuccess());
        print(response.data);
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        print(response.data);

        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(
            UpdateFamilyFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(
            UpdateFamilyFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(UpdateFamilyFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updateFamilyPassword({
    required String id,
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(UpdateFamilyPasswordLoading());
    try {
      final response = await dioHelper.patchData(
        endPoint: ApiConstants.updateFamilyPasswordUrl(id: id),
        body: {"oldPassword": oldPassword, "newPassword": newPassword},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateFamilyPasswordSuccess());
        print(response.data);
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        print(response.data);

        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(UpdateFamilyPasswordFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(UpdateFamilyPasswordFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(UpdateFamilyPasswordFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  FamiliesIdsModel? familiesIdsModel;

  void getAllFamiliesIds() async {
    emit(GetAllFamiliesIdsLoading());

    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllFamiliesIdsUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        familiesIdsModel = FamiliesIdsModel.fromJson(response.data);
        print("family Ids data ${response.data}");
        emit(GetAllFamiliesIdsSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllFamiliesIdsFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllFamiliesIdsFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GetAllFamiliesIdsFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }
}
