part of 'announcement_cubit.dart';

@immutable
sealed class AnnouncementState {}

final class AnnouncementInitial extends AnnouncementState {}
final class AddNewAnnouncementLoading extends AnnouncementState {}

final class AddNewAnnouncementSuccess extends AnnouncementState {}

final class AddNewAnnouncementFailure extends AnnouncementState {
  final ErrorModel errorModel;

  AddNewAnnouncementFailure({required this.errorModel});
}
final class GetAllAnnouncementLoading extends AnnouncementState {}
final class GetAllAnnouncementSuccess extends AnnouncementState {}

final class GetAllAnnouncementFailure extends AnnouncementState {
  final ErrorModel errorModel;

  GetAllAnnouncementFailure({required this.errorModel});
}


final class DeleteAnnouncementLoading extends AnnouncementState {}

final class DeleteAnnouncementSuccess extends AnnouncementState {}

final class DeleteAnnouncementFailure extends AnnouncementState {
  final ErrorModel errorModel;

  DeleteAnnouncementFailure({required this.errorModel});
}


final class DeleteAllAnnouncementLoading extends AnnouncementState {}

final class DeleteAllAnnouncementSuccess extends AnnouncementState {}

final class DeleteAllAnnouncementFailure extends AnnouncementState {
  final ErrorModel errorModel;

  DeleteAllAnnouncementFailure({required this.errorModel});
}

final class UpdateAnnouncementLoading extends AnnouncementState {}

final class UpdateAnnouncementSuccess extends AnnouncementState {}

final class UpdateAnnouncementFailure extends AnnouncementState {
  final ErrorModel errorModel;

  UpdateAnnouncementFailure({required this.errorModel});
}

// New state for handling notifications
final class NotificationReceivedState extends AnnouncementState {
  final List<Map<String, dynamic>> notifications;

  NotificationReceivedState({required this.notifications});
}