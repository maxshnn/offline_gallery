import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_gallery/data/datasource/local/image_local_datasource.dart';
import 'package:offline_gallery/data/datasource/remote/image_remote_datasource.dart';
import 'package:offline_gallery/data/model/image_model.dart';

void main() {
  final dio = Dio();
  final imageRemoteDatasource = ImageRemoteDatasource(dio: dio);
  final imageLocalDatasource = ImageLocalDatasource();

  group('image datasource test', () {
    test(
      'remote datasource',
      () async {
        final data = await imageRemoteDatasource.readAll();
        expect(data.first.image, isNotEmpty);
      },
    );
    test(
      'local datasource',
      () async {
        final image = ImageModel(id: 0, image: 'asdasd');
        await imageLocalDatasource.insertImages([image]);
        final images = await imageLocalDatasource.readAll();
        expect(images, isNotEmpty);
        await imageLocalDatasource.deleteAll();
      },
    );
  });
}
