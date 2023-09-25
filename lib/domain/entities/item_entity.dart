import 'package:equatable/equatable.dart';
import 'package:yawar_task/data/models/user_model.dart';
import '../../data/models/interactions_count_types_model.dart';
import '../../data/models/media_model.dart';

class Item extends Equatable {
  final int id;
  final int userId;
  final int? parentId;
  final String modelType;
  final int modelId;
  final String? content;
  final int index;
  final int status;
  final int type;
  final String createdAt;
  final String updatedAt;
  final int interactionsCount;
  final InteractionsCountTypesModel interactionsCountTypes;
  final int commentsCount;
  final int sharesCount;
  final int tagsCount;
  final bool sharingPost;
  final bool? saved;
  final bool? taged;
  final UserModel model;
  final bool hasMedia;
  final List<MediaModel> media;
  final List<dynamic> tags;

  const Item({
    required this.id,
    required this.userId,
    this.parentId,
    required this.modelType,
    required this.modelId,
    required this.content,
    required this.index,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.interactionsCount,
    required this.interactionsCountTypes,
    required this.commentsCount,
    required this.sharesCount,
    required this.tagsCount,
    required this.sharingPost,
    this.saved,
    this.taged,
    required this.model,
    required this.hasMedia,
    required this.media,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        parentId,
        modelType,
        modelId,
        content,
        index,
        status,
        type,
        createdAt,
        updatedAt,
        interactionsCount,
        interactionsCountTypes,
        commentsCount,
        sharesCount,
        tagsCount,
        sharingPost,
        saved,
        taged,
        model,
        hasMedia,
        media,
        tags,
      ];
}
