import 'package:offline_gallery/data/datasource/local/image_local_datasource.dart';
import 'package:offline_gallery/data/datasource/remote/image_remote_datasource.dart';
import 'package:offline_gallery/data/model/image_model.dart';
import 'package:offline_gallery/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageLocalDatasource _imageLocalDatasource;
  final ImageRemoteDatasource _imageRemoteDatasource;

  ImageRepositoryImpl({
    required ImageLocalDatasource imageLocalDatasource,
    required ImageRemoteDatasource imageRemoteDatasource,
  })  : _imageLocalDatasource = imageLocalDatasource,
        _imageRemoteDatasource = imageRemoteDatasource;

  @override
  Future<List<ImageModel>> getAll() async {
    final images = await _imageRemoteDatasource.readAll();
    await _imageLocalDatasource.insertImages(images);
    return images;
  }

  @override
  Future<List<ImageModel>> getAllCached() {
    return _imageLocalDatasource.readAll();
  }
}
