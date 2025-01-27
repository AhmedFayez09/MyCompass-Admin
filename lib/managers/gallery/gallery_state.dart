part of 'gallery_cubit.dart';

@immutable
sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}
final class GetAllGalleryLoading extends GalleryState {}

final class GetAllGallerySuccess extends GalleryState {}

final class GetAllGalleryFailure extends GalleryState {
  final ErrorModel errorModel;

  GetAllGalleryFailure({required this.errorModel});
}

final class AddGalleryLoading extends GalleryState {}
final class AddGallerySuccess extends GalleryState {}

final class AddGalleryFailure extends GalleryState {
  final ErrorModel errorModel;

  AddGalleryFailure({required this.errorModel});
}
final class DeleteGalleryLoading extends GalleryState {}
final class DeleteGallerySuccess extends GalleryState {}

final class DeleteGalleryFailure extends GalleryState {
  final ErrorModel errorModel;

  DeleteGalleryFailure({required this.errorModel});
}
final class DeleteAllGalleryLoading extends GalleryState {}
final class DeleteAllGallerySuccess extends GalleryState {}

final class DeleteAllGalleryFailure extends GalleryState {
  final ErrorModel errorModel;

  DeleteAllGalleryFailure({required this.errorModel});
}


final class UpdateGalleryLoading extends GalleryState {}

final class UpdateGallerySuccess extends GalleryState {}

final class UpdateGalleryFailure extends GalleryState {
  final ErrorModel errorModel;

  UpdateGalleryFailure({required this.errorModel});
}
