import 'package:dartz/dartz.dart';
import 'package:yawar_task/domain/repository/base_posts_repository.dart';

import '../../core/error/failure.dart';
import '../entities/item_entity.dart';

class GetPostsUseCase {
  final BasePostsRepository repository;

  GetPostsUseCase(this.repository);

  Future<Either<Failure, List<Item>>> call(
      {required bool isPagination, required int currentPage}) async {
    final page = isPagination ? currentPage + 1 : 1;
    return await repository.getPosts(page);
  }
}
