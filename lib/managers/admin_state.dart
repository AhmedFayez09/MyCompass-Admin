part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

/// Login
final class AdminLoginLoading extends AdminState {}

final class AdminLoginSuccess extends AdminState {
  final String? message;

  AdminLoginSuccess({this.message});
}

final class AdminLoginFailure extends AdminState {
  final ErrorModel errorModel;

  AdminLoginFailure({required this.errorModel});
}

final class GetProfileLoading extends AdminState {}

final class GetProfileSuccess extends AdminState {}

final class GetProfileFailure extends AdminState {
  final ErrorModel errorModel;

  GetProfileFailure({required this.errorModel});
}

final class GetAllEmployeesAndFamiliesIsdLoading extends AdminState {}

final class GetAllEmployeesAndFamiliesIsdSuccess extends AdminState {}

final class GetAllEmployeesAndFamiliesIsdFailure extends AdminState {
  final ErrorModel errorModel;

  GetAllEmployeesAndFamiliesIsdFailure({required this.errorModel});
}

final class CreateFastNotificationLoading extends AdminState {}
final class CreateCustomNotificationLoading extends AdminState {}
final class CreateCustomNotificationSuccess extends AdminState {}
 final class CreateFastNotificationSuccess extends AdminState {}

final class CreateFastNotificationFailure extends AdminState {
  final ErrorModel errorModel;

  CreateFastNotificationFailure({required this.errorModel});
}




// New state for handling notifications
final class NotificationReceivedState extends AdminState {
  final List<Map<String, dynamic>> notifications;

  NotificationReceivedState({required this.notifications});
}



final class GetUsersStatesLoading extends AdminState {}

final class GetUsersStatesSuccess extends AdminState {}

final class GetUsersStatesFailure extends AdminState {
  final ErrorModel errorModel;

  GetUsersStatesFailure({required this.errorModel});
}
final class NotResponsedLoading extends AdminState {}
final class NotResponsedSuccess extends AdminState {}
final class NotResponsedFailure extends AdminState {
  final ErrorModel errorModel;

  NotResponsedFailure({required this.errorModel});

}

