import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../file_video_player_component.dart';

class CreatePostMediaComponent extends StatelessWidget {
  final List<Map<String, dynamic>> media;
  const CreatePostMediaComponent({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final postImages =
        media.where((element) => element['media_type'] == 'Image').toList();
    final postVideos =
        media.where((element) => element['media_type'] == 'Video').toList();
    final itemCount = media.length;

    return media.isNotEmpty
        ? SingleChildScrollView(
            child: Wrap(
                children: List.generate(itemCount, (index) {
              double itemWidth = 0.5.sw;
              double itemHieght = 0.5.sw;

              if (index == 0 && itemCount >= 3) {
                itemWidth = 1.sw;
              }
              if (itemCount == 1) {
                itemWidth = 1.sw;
                itemHieght = postVideos[index]['height'].toDouble().h / 1.7;
              }
              return media[index]['media_type'] == 'Image'
                  ? Container(
                      width: itemWidth,
                      height: media[index]['height'].toDouble(),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(postImages[index]['filePath'])),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : FileVideoPlayer(
                      videoUrl: postVideos[index]['filePath'],
                      width: itemWidth.toDouble(),
                      height: itemHieght,
                    );
            })),
          )
        : const SizedBox();
  }
}
