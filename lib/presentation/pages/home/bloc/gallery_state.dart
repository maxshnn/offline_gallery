part of 'gallery_bloc.dart';

sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}

final class GallerySuccess extends GalleryState {
  final List<ImageModel> images;

  GallerySuccess({required this.images});
}

final class GalleryLoading extends GalleryState {}

final class GalleryFailed extends GalleryState {
  final Exception error;
  final String message;

  GalleryFailed({required this.error, required this.message});
}
