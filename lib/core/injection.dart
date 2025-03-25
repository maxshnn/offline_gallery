import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:offline_gallery/data/datasource/local/image_local_datasource.dart';
import 'package:offline_gallery/data/datasource/remote/image_remote_datasource.dart';
import 'package:offline_gallery/data/interceptors/network_interceptor.dart';
import 'package:offline_gallery/data/repositories/image_repository_impl.dart';
import 'package:offline_gallery/domain/repositories/image_repository.dart';
import 'package:offline_gallery/domain/use_cases/image_use_case.dart';

final injection = GetIt.instance;

void setup() {
  final dio = Dio()
    ..interceptors.add(
      NetworkInterceptor(),
    );

  injection
    ..registerLazySingleton<ImageLocalDatasource>(
      () => ImageLocalDatasource(),
    )
    ..registerLazySingleton<ImageRemoteDatasource>(
      () => ImageRemoteDatasource(dio: dio),
    )
    ..registerLazySingleton<ImageRepository>(
      () => ImageRepositoryImpl(
        imageLocalDatasource: injection(),
        imageRemoteDatasource: injection(),
      ),
    )
    ..registerLazySingleton<ImageUseCase>(
      () => ImageUseCase(
        imageRepository: injection(),
      ),
    );
}
