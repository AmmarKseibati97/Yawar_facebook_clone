import '../../domain/entities/interactions_count_types_entity.dart';

class InteractionsCountTypesModel extends InteractionsCountTypes {
  const InteractionsCountTypesModel({
    required super.like,
    required super.love,
    required super.care,
    required super.haha,
    required super.wow,
    required super.sad,
    required super.angry,
  });

  factory InteractionsCountTypesModel.fromJson(Map<String, dynamic> json) {
    return InteractionsCountTypesModel(
      like: json['like'] ?? 0,
      love: json['love'] ?? 0,
      care: json['care'] ?? 0,
      haha: json['haha'] ?? 0,
      wow: json['wow'] ?? 0,
      sad: json['sad'] ?? 0,
      angry: json['angry'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'like': like,
      'love': love,
      'care': care,
      'haha': haha,
      'wow': wow,
      'sad': sad,
      'angry': angry,
    };
  }
}
