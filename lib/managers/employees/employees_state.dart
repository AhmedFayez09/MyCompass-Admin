part of 'employees_cubit.dart';

@immutable
sealed class EmployeesState {}

final class EmployeesInitial extends EmployeesState {}

final class GEtAllEmployeesLoading extends EmployeesState {}

final class GEtAllEmployeesSuccess extends EmployeesState {}

final class GEtAllEmployeesFailure extends EmployeesState {
  final ErrorModel errorModel;

  GEtAllEmployeesFailure({required this.errorModel});
}

final class DeleteEmployeeLoading extends EmployeesState {}


final class DeleteEmployeeSuccess extends EmployeesState {}

final class DeleteEmployeeFailure extends EmployeesState {
  final ErrorModel errorModel;

  DeleteEmployeeFailure({required this.errorModel});
}

class AddEmployeeLoading extends EmployeesState {}

class AddEmployeeSuccess extends EmployeesState {}

class AddEmployeeFailure extends EmployeesState {
  final ErrorModel errorModel;

  AddEmployeeFailure({required this.errorModel});
}



class GetEmployeesIdsLoading extends EmployeesState {}

class GetEmployeesIdsSuccess extends EmployeesState {}

class GetEmployeesIdsFailure extends EmployeesState {
  final ErrorModel errorModel;

  GetEmployeesIdsFailure({required this.errorModel});
}
class UpdateEmployeeLoading extends EmployeesState {}

class UpdateEmployeeSuccess extends EmployeesState {}

class UpdateEmployeeFailure extends EmployeesState {
  final ErrorModel errorModel;

  UpdateEmployeeFailure({required this.errorModel});
}
