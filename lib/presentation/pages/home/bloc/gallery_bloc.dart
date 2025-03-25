import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:offline_gallery/data/model/image_model.dart';
import 'package:offline_gallery/domain/use_cases/image_use_case.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final ImageUseCase _imageUseCase;
  GalleryBloc({required ImageUseCase imageUseCase})
      : _imageUseCase = imageUseCase,
        super(GalleryInitial()) {
    on<FetchData>(_onFetchData);
    on<FetchCachedData>(_onFetchCachedData);
  }

  Future<void> _onFetchData(FetchData event, Emitter emit) async {
    emit(GalleryLoading());
    try {
      final data = await _imageUseCase.getAll();
      emit(GallerySuccess(images: data));
    } on DioException catch (e) {
      emit(
        GalleryFailed(error: e, message: e.message ?? ''),
      );
    }
  }

  Future<void> _onFetchCachedData(FetchCachedData event, Emitter emit) async {
    emit(GalleryLoading());
    try {
      final data = await _imageUseCase.getAllCached();
      emit(GallerySuccess(images: data));
    } on DioException catch (e) {
      emit(
        GalleryFailed(error: e, message: e.message ?? ''),
      );
    }
  }
}
