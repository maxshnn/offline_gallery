part of 'gallery_bloc.dart';

sealed class GalleryEvent {}

final class FetchData extends GalleryEvent {}

final class FetchCachedData extends GalleryEvent {}
