part of 'maintenance_cubit.dart';

@immutable
sealed class MaintenanceState {}

final class MaintenanceInitial extends MaintenanceState {}
final class GetAllMaintenanceLoading extends MaintenanceState {}
final class GetAllMaintenanceSuccess extends MaintenanceState {}
final class GetAllMaintenanceFailure extends MaintenanceState {
  final ErrorModel errorModel;

  GetAllMaintenanceFailure({required this.errorModel});

}
final class ChangeMaintenanceStateLoading extends MaintenanceState {}
final class ChangeMaintenanceStateSuccess extends MaintenanceState {}
final class ChangeMaintenanceStateFailure extends MaintenanceState {
  final ErrorModel errorModel;

  ChangeMaintenanceStateFailure({required this.errorModel});

}

