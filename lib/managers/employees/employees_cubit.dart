import 'package:bloc/bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/models/employee_model.dart';
import 'package:mycompass_admin_website/models/error/error_model.dart';
import 'package:mycompass_admin_website/models/families_ids_model.dart';
export 'package:dio/dio.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit() : super(EmployeesInitial());

  static EmployeesCubit of(context) => BlocProvider.of<EmployeesCubit>(context);

  DioHelper dioHelper = DioHelper();

  EmployeeModel? employeeModel;

  void getAllEmployees() async {
    emit(GEtAllEmployeesLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllEmployeesUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        employeeModel = EmployeeModel.fromJson(response.data);
        emit(GEtAllEmployeesSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GEtAllEmployeesFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GEtAllEmployeesFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GEtAllEmployeesFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }

  void deleteEmployee({required String id}) async {
    emit(DeleteEmployeeLoading());
    try {
      final response = await dioHelper.deleteData(
          endPoint: ApiConstants.deleteEmployeeUrl(id: id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteEmployeeSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(DeleteEmployeeFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(DeleteEmployeeFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(
          DeleteEmployeeFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void addEmployee(
      {required String userName,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required List<String> days,
      required List<String> workSpecialization,
      required List<String> languages}) async {
    emit(AddEmployeeLoading());
    print(userName);
    print(email);
    print(phone);
    print(password);
    print(confirmPassword);
    print(days);
    print(languages);
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.addEmployeeUrl,
        body: {
          "userName": userName,
          "email": email,
          "password": password,
          "cPassword": confirmPassword,
          "phone": phone,
          "languages": languages,
          "days": days,
          "workSpecialization" : workSpecialization
        },
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddEmployeeSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(AddEmployeeFailure(errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(AddEmployeeFailure(errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(AddEmployeeFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  void updateEmployee({
    required String id,
    String? userName,
    String? phone,
    String? oldPassword,
    String? newPassword,
    List<String>? days,
    List<String>? languages,
    List<String>? workSpecialization,
  }) async {
    emit(UpdateEmployeeLoading());
print(id);
print(userName);
print(phone);
print(oldPassword);
print(newPassword);
print(days);
print(languages);
    try {
      final response = await dioHelper.patchData(
        endPoint: ApiConstants.updateEmployeeUrl(id: id),
        body: {
          if (userName != null) "userName": userName,
          if (phone != null) "phone": phone,
          if (languages != null) "languages": languages,
          if (days != null) "days": days,
          if (oldPassword != null) "oldPassword": oldPassword,
          if (newPassword != null) "newPassword": newPassword,
          if (workSpecialization != null) "workSpecialization": workSpecialization
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateEmployeeSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404 || response.statusCode == 400) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(UpdateEmployeeFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(UpdateEmployeeFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(
          UpdateEmployeeFailure(errorModel: ErrorModel(message: e.toString())));
    }
  }

  FamiliesIdsModel? employeesIdsModel;

  void getEmployeesIds() async {
    emit(GetEmployeesIdsLoading());
    try {
      final response =
          await dioHelper.getData(endPoint: ApiConstants.getAllEmployeesIdsUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        employeesIdsModel = FamiliesIdsModel.fromJson(response.data);
        emit(GetEmployeesIdsSuccess());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        final errorMessage =
            response.data['message']?.toString() ?? 'Unknown error';
        logError(errorMessage);
        emit(GetEmployeesIdsFailure(
            errorModel: ErrorModel(message: errorMessage)));
      } else {
        final errorMessage =
            response.data['message']?.toString() ?? 'Error in Creating Family';
        logError(errorMessage);
        emit(GetEmployeesIdsFailure(
            errorModel: ErrorModel(message: errorMessage)));
      }
    } catch (e) {
      logError(e.toString());
      emit(GetEmployeesIdsFailure(
          errorModel: ErrorModel(message: e.toString())));
    }
  }
}
