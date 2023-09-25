import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/media_model.dart';

class PostInfoComponent extends StatefulWidget {
  final String userName;
  final String postTime;
  final List<MediaModel> profileImage;
  const PostInfoComponent(
      {super.key,
      required this.userName,
      required this.postTime,
      required this.profileImage});

  @override
  State<PostInfoComponent> createState() => _PostInfoComponentState();
}

class _PostInfoComponentState extends State<PostInfoComponent> {
  late String farthestDifference;
  late List<MediaModel> image;

  @override
  void initState() {
    super.initState();
    getPostTime();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.08.sh,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: image.isNotEmpty
            ? CircleAvatar(
                radius: 28.w,
                backgroundImage: NetworkImage(image.first.srcUrl),
              )
            : CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 36.sp.sp,
                ),
              ),
        title: Text(widget.userName),
        subtitle: Text(farthestDifference),
      ),
    );
  }

  getPostTime() {
    image = widget.profileImage
        .where((element) => element.modelType == 'Profile')
        .toList();
    DateTime currentTime = DateTime.now().toUtc();

    DateTime targetDateTime = DateTime.parse(widget.postTime);

    Duration difference = currentTime.difference(targetDateTime);

    int minutesDifference = difference.inMinutes;
    int hoursDifference = difference.inHours;
    int daysDifference = difference.inDays;
    int monthsDifference = (currentTime.year - targetDateTime.year) * 12 +
        (currentTime.month - targetDateTime.month);

    String timeUnit;
    int timeValue;

    if (monthsDifference > 0) {
      timeValue = monthsDifference;
      timeUnit = timeValue > 1 ? 'months' : 'month';

      farthestDifference = '$timeValue $timeUnit';
    } else if (daysDifference > 0) {
      timeValue = daysDifference;
      timeUnit = timeValue > 1 ? 'days' : 'day';

      farthestDifference = '$timeValue $timeUnit';
    } else if (hoursDifference > 0) {
      timeValue = hoursDifference;
      timeUnit = timeValue > 1 ? 'hours' : 'hour';

      farthestDifference = '$timeValue $timeUnit';
    } else {
      timeValue = minutesDifference;
      timeUnit = timeValue > 1 ? 'minutes' : 'minute';

      farthestDifference = timeValue == 0 ? 'just now' : '$timeValue $timeUnit';
    }
  }
}
