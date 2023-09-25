import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';
import '../../../../domain/entities/item_entity.dart';

class PostState extends Equatable {
  final List<Item> posts;
  final RequestState postsState;
  final String postsMessage;
  final int currentPage;
  final bool isPagination;

  final RequestState createPostState;
  final String createPostsMessage;

  const PostState({
    this.posts = const [],
    this.postsState = RequestState.loading,
    this.postsMessage = "",
    this.currentPage = 1,
    this.isPagination = false,
    this.createPostState = RequestState.loaded,
    this.createPostsMessage = "",
  });

  PostState copyWith({
    List<Item>? posts,
    RequestState? postsState,
    String? postsMessage,
    int? currentPage,
    bool? isPagination,
    RequestState? createPostState,
    String? createPostsMessage,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      postsState: postsState ?? this.postsState,
      postsMessage: postsMessage ?? this.postsMessage,
      currentPage: currentPage ?? this.currentPage,
      isPagination: isPagination ?? this.isPagination,
      createPostState: createPostState ?? this.createPostState,
      createPostsMessage: createPostsMessage ?? this.createPostsMessage,
    );
  }

  @override
  List<Object?> get props => [
        posts,
        postsMessage,
        postsState,
        currentPage,
        isPagination,
        createPostState,
        createPostsMessage,
      ];
}
