import 'package:equatable/equatable.dart';
import 'package:yawar_task/data/models/media_model.dart';

class User extends Equatable {
  final int id;
  final int userId;
  final String? sn;
  final String firstName;
  final String? middleName;
  final String lastName;
  final int gender;
  final bool isBlocked;
  final String? blockedUntil;
  final String createdAt;
  final String updatedAt;
  final String lastSeen;
  final String name;
  final int? isFriend;
  final int? mutualfriendsCount;
  final bool screenBlock;
  final bool hasMediaProfile;
  final bool hasMediaCover;
  final List<MediaModel> media;

  const User({
    required this.id,
    required this.userId,
    this.sn,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender,
    required this.isBlocked,
    this.blockedUntil,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSeen,
    required this.name,
    this.isFriend,
    this.mutualfriendsCount,
    required this.screenBlock,
    required this.hasMediaProfile,
    required this.hasMediaCover,
    required this.media,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        sn,
        firstName,
        middleName,
        lastName,
        gender,
        isBlocked,
        blockedUntil,
        createdAt,
        updatedAt,
        lastSeen,
        name,
        isFriend,
        mutualfriendsCount,
        screenBlock,
        hasMediaProfile,
        hasMediaCover,
        media,
      ];
}
