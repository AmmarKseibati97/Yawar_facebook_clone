import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/item_entity.dart';

abstract class BasePostsRepository {
  Future<Either<Failure, List<Item>>> getPosts(int page);
  Future<Either<Failure, void>> createPost(
      String content, List<Map<String, dynamic>> mediaList);
}
