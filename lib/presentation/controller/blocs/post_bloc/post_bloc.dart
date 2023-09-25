// ignore: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawar_task/domain/usecases/create_post_usecase.dart';
import 'package:yawar_task/domain/usecases/get_posts_usecase.dart';
import 'package:yawar_task/presentation/controller/blocs/post_bloc/post_event.dart';
import 'package:yawar_task/presentation/controller/blocs/post_bloc/post_state.dart';

import '../../../../core/utils/app_constances/app_functions.dart';
import '../../../../core/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;

  PostBloc(
    this.getPostsUseCase,
    this.createPostUseCase,
  ) : super(const PostState()) {
    on<GetPostsEvent>(_getPosts);
    on<CreatePostEvent>(_createPost);
  }

  FutureOr<void> _getPosts(GetPostsEvent event, Emitter<PostState> emit) async {
    if (!event.isPagination) {
      emit(state.copyWith(postsState: RequestState.loading));
    }

    final result = await getPostsUseCase(
      isPagination: event.isPagination,
      currentPage: state.currentPage,
    );
    result.fold(
      (l) => emit(state.copyWith(
        postsState: RequestState.error,
        postsMessage: l.message,
      )),
      (r) {
        final updatedPosts = event.isPagination ? [...state.posts, ...r] : r;

        emit(state.copyWith(
          posts: updatedPosts,
          postsState: RequestState.loaded,
          currentPage: event.isPagination ? state.currentPage + 1 : 1,
          isPagination: false,
        ));
      },
    );
  }

  FutureOr<void> _createPost(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(createPostState: RequestState.loading));

    final result = await createPostUseCase(event.content, event.mediaList);

    result.fold((l) {
      emit(state.copyWith(
        createPostState: RequestState.error,
        createPostsMessage: l.message,
      ));
      AppFunctions.showToast();
    }, (r) {
      emit(state.copyWith(
        createPostState: RequestState.loaded,
      ));
      event.context
          .read<PostBloc>()
          .add(const GetPostsEvent(isPagination: false));

      Navigator.pop(event.context);
    });

    AppFunctions.mediaList.clear();
  }
}
