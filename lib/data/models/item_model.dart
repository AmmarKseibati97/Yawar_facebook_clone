import 'package:yawar_task/data/models/user_model.dart';
import 'package:yawar_task/domain/entities/item_entity.dart';

import 'interactions_count_types_model.dart';
import 'media_model.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.userId,
    super.parentId,
    required super.modelType,
    required super.modelId,
    required super.content,
    required super.index,
    required super.status,
    required super.type,
    required super.createdAt,
    required super.updatedAt,
    required super.interactionsCount,
    required super.interactionsCountTypes,
    required super.commentsCount,
    required super.sharesCount,
    required super.tagsCount,
    required super.sharingPost,
    super.saved,
    super.taged,
    required super.model,
    required super.hasMedia,
    required super.media,
    required super.tags,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      parentId: json['parent_id'] ?? 0,
      modelType: json['model_type'] ?? "",
      modelId: json['model_id'] ?? 0,
      content: json['content'] ?? "",
      index: json['index'] ?? 0,
      status: json['status'] ?? 0,
      type: json['type'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      interactionsCount: json['interactions_count'] ?? 0,
      interactionsCountTypes: InteractionsCountTypesModel.fromJson(
          json['interactions_count_types'] as Map<String, dynamic>),
      commentsCount: json['comments_count'] ?? 0,
      sharesCount: json['shares_count'] ?? 0,
      tagsCount: json['tags_count'] ?? 0,
      sharingPost: json['sharing_post'] as bool,
      saved: json['saved'] ?? false,
      taged: json['taged'] ?? false,
      model: UserModel.fromJson(json['model'] as Map<String, dynamic>),
      hasMedia: json['has_media'],
      media: (json['media'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: json['tags'] as List<dynamic>,
    );
  }
}
