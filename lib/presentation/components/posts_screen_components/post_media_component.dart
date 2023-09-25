import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yawar_task/data/models/media_model.dart';

import '../network_video_player_component.dart';

class PostMediaComponent extends StatefulWidget {
  final List<MediaModel> media;
  const PostMediaComponent({super.key, required this.media});

  @override
  State<PostMediaComponent> createState() => _PostMediaComponentState();
}

class _PostMediaComponentState extends State<PostMediaComponent> {
  late List<MediaModel> allMedia;
  late List<MediaModel> postImages;
  late List<MediaModel> postVideos;
  late int itemCount;
  @override
  void initState() {
    getMedia();
    super.initState();
  }

  getMedia() {
    allMedia =
        widget.media.where((element) => element.modelType == 'Post').toList();
    postImages =
        allMedia.where((element) => element.mediaType == 'Image').toList();
    postVideos =
        allMedia.where((element) => element.mediaType == 'Video').toList();
    itemCount = allMedia.length;
  }

  @override
  Widget build(BuildContext context) {
    final custimCahceManager = CacheManager((Config('customCacheKey',
        stalePeriod: const Duration(days: 1),
        maxNrOfCacheObjects: widget.media.length)));

    return allMedia.isNotEmpty
        ? Wrap(
            children: List.generate(
              itemCount > 3 ? 3 : itemCount,
              (index) {
                double itemWidth = 0.449.sw;
                double itemHieght = 0.25.sh;

                if (index == 0 && itemCount >= 3) {
                  itemWidth = 1.sw;
                }
                if (itemCount == 1) {
                  itemWidth = 0.949.sw;
                  itemHieght = widget.media[index].height.toDouble().h / 1.7;
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    allMedia[index].mediaType == 'Image'
                        ? CachedNetworkImage(
                            cacheManager: custimCahceManager,
                            key: UniqueKey(),
                            imageUrl: postImages[index].srcUrl,
                            width: itemWidth,
                            height: itemHieght,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(),
                            useOldImageOnUrlChange: true,
                            errorWidget: (context, url, error) {
                              return Container(
                                width: itemWidth,
                                height: (1.sh / 6),
                                color: Colors.white,
                              );
                            },
                          )
                        : NetworkVideoPlayer(
                            videoUrl: postVideos[index].srcUrl,
                            width: postVideos[index].width.toDouble(),
                            height: itemHieght,
                          ),
                    index == 2 && itemCount > 3
                        ? Text(
                            "$itemCount+",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 36.sp),
                          )
                        : const SizedBox()
                  ],
                );
              },
            ),
          )
        : const SizedBox();
  }
}
