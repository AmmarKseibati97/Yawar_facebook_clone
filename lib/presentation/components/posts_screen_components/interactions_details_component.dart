import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/interactions_count_types_model.dart';

class InteractionsDetailsComponent extends StatefulWidget {
  final InteractionsCountTypesModel reactions;
  final int commentsCount;
  const InteractionsDetailsComponent(
      {super.key, required this.reactions, required this.commentsCount});

  @override
  State<InteractionsDetailsComponent> createState() =>
      _InteractionsDetailsComponentState();
}

class _InteractionsDetailsComponentState
    extends State<InteractionsDetailsComponent> {
  List<Map<String, dynamic>> topInteractionsWithImages = [];
  int interactionsCount = 0;

  @override
  void initState() {
    super.initState();
    getInteractions();
  }

  void getInteractions() {
    Map<String, String> images = {
      "like": 'assets/like.png',
      "love": 'assets/love.png',
      "care": 'assets/care.png',
      "haha": 'assets/haha.png',
      "wow": 'assets/wow.png',
      "sad": 'assets/sad.png',
      "angry": 'assets/angry.png',
    };

    List<MapEntry<String, dynamic>> filteredInteractions = widget.reactions
        .toJson()
        .entries
        .where((entry) => entry.value > 0)
        .toList();

    for (int i = 0; i < 3 && i < filteredInteractions.length; i++) {
      String interaction = filteredInteractions[i].key;
      int count = filteredInteractions[i].value;
      String image = images[interaction]!;

      topInteractionsWithImages.add({
        "interaction": interaction,
        "count": count,
        "image": image,
      });
      interactionsCount += count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 0.035.sh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topInteractionsWithImages.isNotEmpty
                ? Row(
                    children: [
                      Row(
                          children: List.generate(
                              topInteractionsWithImages.length,
                              (index) => Container(
                                    width: topInteractionsWithImages[index]
                                                ['interaction'] ==
                                            'like'
                                        ? 28.w
                                        : 20.w,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.2.w),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                        topInteractionsWithImages[index]
                                            ['image'],
                                      ),
                                      fit: BoxFit.contain,
                                    )),
                                  ))),
                      Text("$interactionsCount"),
                    ],
                  )
                : const SizedBox(),
            widget.commentsCount > 0
                ? Text('${widget.commentsCount} comments')
                : const SizedBox()
          ],
        ));
  }
}
