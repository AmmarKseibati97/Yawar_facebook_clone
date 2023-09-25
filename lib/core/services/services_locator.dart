import 'package:get_it/get_it.dart';
import 'package:yawar_task/data/datasource/posts_remote_data_source.dart';
import 'package:yawar_task/data/repository/posts_repository.dart';
import 'package:yawar_task/domain/repository/base_posts_repository.dart';
import 'package:yawar_task/presentation/controller/cubits/media_cubit.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../presentation/controller/blocs/post_bloc/post_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerFactory(() => PostBloc(
          sl(),
          sl(),
        ));
    sl.registerFactory(() => MediaCubit());

    sl.registerLazySingleton(() => GetPostsUseCase(sl()));
    sl.registerLazySingleton(() => CreatePostUseCase(sl()));

    sl.registerLazySingleton<BasePostsRepository>(() => PostsRepository(sl()));

    sl.registerLazySingleton<BasePostsRemoteDataSource>(
        () => PostsRemoteDataSource());
  }
}
