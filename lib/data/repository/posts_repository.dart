import 'package:dartz/dartz.dart';
import 'package:yawar_task/data/datasource/posts_remote_data_source.dart';
import 'package:yawar_task/domain/entities/item_entity.dart';
import '../../core/error/exceptios.dart';
import '../../core/error/failure.dart';
import '../../domain/repository/base_posts_repository.dart';

class PostsRepository extends BasePostsRepository {
  final BasePostsRemoteDataSource basePostsRemoteDataSource;

  PostsRepository(this.basePostsRemoteDataSource);
  @override
  Future<Either<Failure, List<Item>>> getPosts(int page) async {
    try {
      final result = await basePostsRemoteDataSource.getPosts(page: page);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> createPost(
      String content, List<Map<String, dynamic>> mediaList) async {
    try {
      final result =
          await basePostsRemoteDataSource.createPost(content, mediaList);

      return Right(result);
    } on ServerException catch (failuar) {
      return Left(ServerFailure(failuar.errorMessageModel.message));
    }
  }
}
