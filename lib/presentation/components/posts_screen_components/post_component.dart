import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yawar_task/data/models/interactions_count_types_model.dart';
import 'package:yawar_task/presentation/components/posts_screen_components/post_info_component.dart';

import '../../../data/models/media_model.dart';
import 'interactions_details_component.dart';
import 'options_component.dart';
import 'post_media_component.dart';

class PostComponent extends StatelessWidget {
  final String postDescription;
  final bool hasImage;
  final InteractionsCountTypesModel reactions;
  final List<MediaModel> media;
  final int commentsCount;
  final String postTime;
  final String userName;

  const PostComponent({
    super.key,
    required this.postDescription,
    required this.hasImage,
    required this.media,
    required this.reactions,
    required this.commentsCount,
    required this.postTime,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        boxShadow: [
          BoxShadow(
            spreadRadius: -3,
            blurRadius: 5,
            color: const Color.fromARGB(143, 17, 15, 15),
            offset: Offset(1.w, 2.h),
          )
        ],
      ),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostInfoComponent(
                profileImage: media, userName: userName, postTime: postTime),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  postDescription,
                ),
              ),
            ),
            PostMediaComponent(
              media: media,
            ),
            SizedBox(height: 10.h),
            InteractionsDetailsComponent(
              reactions: reactions,
              commentsCount: commentsCount,
            ),
            const Divider(
              color: Colors.black54,
            ),
            const OptionsComponent()
          ],
        ),
      ),
    );
  }
}
