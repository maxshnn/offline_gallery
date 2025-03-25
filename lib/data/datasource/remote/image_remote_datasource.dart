import 'dart:math';

import 'package:dio/dio.dart';
import 'package:offline_gallery/data/model/image_model.dart';

class ImageRemoteDatasource {
  final Dio _dio;
  ImageRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<List<ImageModel>> readAll() async {
    final random = Random();
    var page = random.nextInt(20);
    final response = await _dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: {'limit': 20, 'page': page},
    );
    return (response.data['results'] as List)
        .map((json) => ImageModel.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
