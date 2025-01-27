part of 'admin_fun_cubit.dart';

@immutable
sealed class AdminFunState {}

final class AdminFunInitial extends AdminFunState {}

/// Get All Admins
final class GetAllAdminsLoading extends AdminFunState {}

final class GetAllAdminsSuccess extends AdminFunState {
  GetAllAdminsSuccess();
}

final class GetAllAdminsFailure extends AdminFunState {
  final ErrorModel errorModel;

  GetAllAdminsFailure({required this.errorModel});
}

final class CreateAdminLoading extends AdminFunState {}

final class CreateAdminSuccess extends AdminFunState {
  final String message;

  CreateAdminSuccess({required this.message});
}

final class CreateAdminFailure extends AdminFunState {
  final ErrorModel errorModel;

  CreateAdminFailure({required this.errorModel});
}
final class DeleteAdminLoading extends AdminFunState {}

final class DeleteAdminSuccess extends AdminFunState {
  final String message;

  DeleteAdminSuccess({required this.message});
}

final class DeleteAdminFailure extends AdminFunState {
  final ErrorModel errorModel;

  DeleteAdminFailure({required this.errorModel});
}


final class UpdateAdminLoading extends AdminFunState {}

final class UpdateAdminSuccess extends AdminFunState {}

final class UpdateAdminFailure extends AdminFunState {
  final ErrorModel errorModel;

  UpdateAdminFailure({required this.errorModel});
}
