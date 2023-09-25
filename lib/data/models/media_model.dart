import 'package:yawar_task/domain/entities/media_entity.dart';

class MediaModel extends Media {
  const MediaModel({
    required super.id,
    required super.modelType,
    required super.modelId,
    required super.srcUrl,
    required super.srcIcon,
    required super.srcThum,
    required super.collectionName,
    required super.fullPath,
    required super.mediaType,
    required super.mimeType,
    required super.size,
    required super.width,
    required super.height,
    required super.saved,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] ?? 0,
      modelType: json['model_type'] ?? "",
      modelId: json['model_id'] ?? 0,
      srcUrl: json['src_url'] ?? "",
      srcIcon: json['src_icon'],
      srcThum: json['src_thum'],
      collectionName: json['collection_name'] ?? "",
      fullPath: json['fullPath'] ?? "",
      mediaType: json['media_type'] ?? "",
      mimeType: json['mime_type'] ?? "",
      size: json['size'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      saved: json['saved'],
    );
  }
}
