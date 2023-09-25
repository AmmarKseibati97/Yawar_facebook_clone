import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostEvent {
  final bool isPagination;

  const GetPostsEvent({required this.isPagination});
}

class CreatePostEvent extends PostEvent {
  final String content;
  final List<Map<String, dynamic>> mediaList;
  final BuildContext context;

  const CreatePostEvent({
    required this.mediaList,
    required this.content,
    required this.context,
  });
}
