import 'package:offline_gallery/data/model/image_model.dart';

abstract class ImageRepository {
  Future<List<ImageModel>> getAll();
  Future<List<ImageModel>> getAllCached();
}
