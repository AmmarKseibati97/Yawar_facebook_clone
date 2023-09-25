import 'package:dartz/dartz.dart';

import 'package:yawar_task/domain/repository/base_posts_repository.dart';

import '../../core/error/failure.dart';

class CreatePostUseCase {
  final BasePostsRepository repository;

  CreatePostUseCase(this.repository);
  Future<Either<Failure, void>> call(
      String content, List<Map<String, dynamic>> mediaList) async {
    return await repository.createPost(content, mediaList);
  }
}
