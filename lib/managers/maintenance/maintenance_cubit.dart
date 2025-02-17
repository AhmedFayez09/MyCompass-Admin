import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/maintanance_model.dart';

part 'maintenance_state.dart';

class MaintenanceCubit extends Cubit<MaintenanceState> {
  MaintenanceCubit() : super(MaintenanceInitial());

  static MaintenanceCubit of(context) =>
      BlocProvider.of<MaintenanceCubit>(context);

  DioHelper dioHelper = DioHelper();

  MaintenanceModel? maintenanceModel;

  void getAllMaintenances() async {
    emit(GetAllMaintenanceLoading());
    try {
      final response = await dioHelper.getData(
        endPoint: ApiConstants.getAllMaintenancesUrl,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        maintenanceModel = MaintenanceModel.fromJson(response.data);
        print(response.data);
        emit(GetAllMaintenanceSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetAllMaintenanceFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetAllMaintenanceFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GetAllMaintenanceFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  void changeStatus(
      {required String id,
      required String maintenanceStatus,
        String? feedbackComment}) async {
    emit(ChangeMaintenanceStateLoading());
    try {
      final response = await dioHelper.patchData(
          endPoint: ApiConstants.changeMaintenanceStatusUrl(id: id),
          body: {
            "maintenanceOrderStatuses": maintenanceStatus,
            if(feedbackComment != null && feedbackComment.isNotEmpty)
            "feedbackComment": feedbackComment,
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
         print(response.data);
        emit(ChangeMaintenanceStateSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(ChangeMaintenanceStateFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(ChangeMaintenanceStateFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(ChangeMaintenanceStateFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }


  void deleteMaintenances(String id)async{
    emit(DeleteMaintenanceLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deleteMaintenanceUrl(id: id),
          );
      if (response.statusCode == 200 || response.statusCode == 201) {

        emit(DeleteMaintenanceSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteMaintenanceFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteMaintenanceFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(DeleteMaintenanceFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }









}
