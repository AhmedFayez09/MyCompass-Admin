import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/main/get_all_admins_data_model.dart';

part 'admin_fun_state.dart';

class AdminFunCubit extends Cubit<AdminFunState> {
  AdminFunCubit() : super(AdminFunInitial());

  static AdminFunCubit of(context) => BlocProvider.of<AdminFunCubit>(context);

  DioHelper dioHelper = DioHelper();
  GetAllAdminsDataModel? admins;

  void getAllAdmins() async {
    emit(GetAllAdminsLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllAdminsUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        admins = GetAllAdminsDataModel.fromJson(response.data);
        emit(GetAllAdminsSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(
            GetAllAdminsFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(
            GetAllAdminsFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GetAllAdminsFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void createAdmin({
    required String userName,
    required String email,
    required String password,
    required String cPassword,
    required String phone,
  }) async {
    emit(CreateAdminLoading());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.addAdminUrl,
        body: {
          "userName": userName,
          "email": email,
          "password": password,
          "cPassword": cPassword,
          "phone": phone
        },
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateAdminSuccess(
          message: 'Family created successfully',
        ));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['Error']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(CreateAdminFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(CreateAdminFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(CreateAdminFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteAdmin({required String id}) async {
    emit(DeleteAdminLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deleteAdminUrl(id: id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteAdminSuccess(message: "Admin deleted successfully"));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteAdminFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteAdminFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteAdminFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updateAdmin({
    required String id,
    String? userName,
    String? email,
    String? oldPassword,
    String? newPassword,
    String? phone,
  }) async {
    emit(UpdateAdminLoading());
    try {
      final response = await dioHelper
          .patchData(endPoint: ApiConstants.updateAdminUrl(id: id), body: {
        if (userName != null) "userName": userName,
        if (email != null) "email": email,
        if (oldPassword != null) "oldPassword": oldPassword,
        if (newPassword != null) "newPassword": newPassword,
        if (phone != null) "phone": phone
      });
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateAdminSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(UpdateAdminFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(UpdateAdminFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(UpdateAdminFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }
}
