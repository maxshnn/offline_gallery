import 'package:offline_gallery/data/model/image_model.dart';
import 'package:offline_gallery/domain/repositories/image_repository.dart';

class ImageUseCase {
  final ImageRepository _imageRepository;

  ImageUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  Future<List<ImageModel>> getAll() {
    return _imageRepository.getAll();
  }

  Future<List<ImageModel>> getAllCached() {
    return _imageRepository.getAllCached();
  }
}
