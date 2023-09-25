import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final int id;
  final String modelType;
  final int modelId;
  final String srcUrl;
  final dynamic srcIcon;
  final dynamic srcThum;
  final String collectionName;
  final String fullPath;
  final String mediaType;
  final String mimeType;
  final int size;
  final int width;
  final int height;
  final dynamic saved;

  const Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.srcUrl,
    required this.srcIcon,
    required this.srcThum,
    required this.collectionName,
    required this.fullPath,
    required this.mediaType,
    required this.mimeType,
    required this.size,
    required this.width,
    required this.height,
    required this.saved,
  });

  @override
  List<Object?> get props => [
        id,
        modelType,
        modelId,
        srcUrl,
        srcIcon,
        srcThum,
        collectionName,
        fullPath,
        mediaType,
        mimeType,
        size,
        width,
        height,
        saved,
      ];
}
