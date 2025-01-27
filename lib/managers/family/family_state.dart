part of 'family_cubit.dart';

@immutable
sealed class FamilyState {}

final class FamilyInitial extends FamilyState {}
/// Create New Family

final class CreateNewFamilyLoading extends FamilyState {}

final class CreateNewFamilySuccess extends FamilyState {
  final String? message;

  CreateNewFamilySuccess({this.message});
}

final class CreateNewFamilyFailure extends FamilyState {
  final ErrorModel errorModel;

  CreateNewFamilyFailure({required this.errorModel});
}

/// GEt All Families

final class GetAllFamiliesLoading extends FamilyState {}

final class GetAllFamiliesSuccess extends FamilyState {}

final class GetAllFamiliesFailure extends FamilyState {
  final ErrorModel errorModel;

  GetAllFamiliesFailure({required this.errorModel});
}



/// Delete Family
final class DeleteFamilyLoading extends FamilyState {}

final class DeleteFamilySuccess extends FamilyState {}

final class DeleteFamilyFailure extends FamilyState {
  final ErrorModel errorModel;

  DeleteFamilyFailure({required this.errorModel});
}


/// Update Family

final class UpdateFamilyLoading extends FamilyState {}

final class UpdateFamilySuccess extends FamilyState {}

final class UpdateFamilyFailure extends FamilyState {
  final ErrorModel errorModel;

  UpdateFamilyFailure({required this.errorModel});
}

/// Update Family Password


final class UpdateFamilyPasswordLoading extends FamilyState {}

final class UpdateFamilyPasswordSuccess extends FamilyState {}

final class UpdateFamilyPasswordFailure extends FamilyState {
  final ErrorModel errorModel;

  UpdateFamilyPasswordFailure({required this.errorModel});
}


final class GetAllFamiliesIdsLoading extends FamilyState {}

final class GetAllFamiliesIdsSuccess extends FamilyState {}

final class GetAllFamiliesIdsFailure extends FamilyState {
  final ErrorModel errorModel;

  GetAllFamiliesIdsFailure({required this.errorModel});
}
