import 'package:yawar_task/data/models/media_model.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.userId,
    super.sn,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.gender,
    required super.isBlocked,
    super.blockedUntil,
    required super.createdAt,
    required super.updatedAt,
    required super.lastSeen,
    required super.name,
    super.isFriend,
    super.mutualfriendsCount,
    required super.screenBlock,
    required super.hasMediaProfile,
    required super.hasMediaCover,
    required super.media,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userId: json['user_id'] ?? 0,
      sn: json['sn'] ?? "",
      firstName: json['first_name'] ?? "",
      middleName: json['middle_name'],
      lastName: json['last_name'] ?? "",
      gender: json['gender'] ?? 0,
      isBlocked: json['isBlocked'] ?? false,
      blockedUntil: json['blocked_until'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      lastSeen: json['last_seen'] ?? "",
      name: json['name'] ?? "",
      isFriend: json['is_friend'],
      mutualfriendsCount: json['mutualfriends_count'],
      screenBlock: json['screen_block'] ?? false,
      hasMediaProfile: json['has_media_profile'] ?? false,
      hasMediaCover: json['has_media_cover'] ?? false,
      media: (json['media'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
