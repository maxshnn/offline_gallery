import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_gallery/core/injection.dart';
import 'package:offline_gallery/data/model/image_model.dart';
import 'package:offline_gallery/presentation/blocs/cubit/connectivity_cubit.dart';
import 'package:offline_gallery/presentation/pages/home/bloc/gallery_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GalleryBloc(
            imageUseCase: injection(),
          ),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
      ],
      child: BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivityConnected) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.read<GalleryBloc>().add(
                  FetchData(),
                );
          }
          if (state is ConnectivityDisconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(hours: 24),
                content: Text("Отсутствует интернет соединение"),
              ),
            );
            context.read<GalleryBloc>().add(
                  FetchCachedData(),
                );
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.read<GalleryBloc>().add(
                      FetchData(),
                    ),
                icon: const Icon(Icons.replay_outlined),
              ),
              actions: const [
                Text('<--- форсированно получить данные из интернета'),
                Text(''),
              ],
            ),
            body: BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                return switch (state) {
                  GallerySuccess(images: final images) =>
                    _buildImageGridViewWidget(context, images),
                  GalleryFailed(message: final message) =>
                    _buildErrorWidget(context, message),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                };
              },
            ),
          );
        }),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width ~/ 150;
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Произошла ошибка!',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImageGridViewWidget(
      BuildContext context, List<ImageModel> images) {
    if (images.isEmpty) {
      return const Center(
        child: Text('Здесь пока пусто :('),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: 1,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      itemCount: images.length,
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          errorWidget: (context, url, error) => const Center(
            child: Text(
              'Не удалось загрузить фотографию',
              textAlign: TextAlign.center,
            ),
          ),
          imageUrl: images[index].image,
        ),
      ),
    );
  }
}
