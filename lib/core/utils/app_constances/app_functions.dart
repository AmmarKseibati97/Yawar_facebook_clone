// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart';
import 'package:image/image.dart' as img;

import '../../../presentation/controller/blocs/post_bloc/post_bloc.dart';
import '../../../presentation/controller/blocs/post_bloc/post_event.dart';
import '../../../presentation/screens/create_post_screen.dart';

class AppFunctions {
  static List<Map<String, dynamic>> mediaList = [];

  static Future<List<Map<String, dynamic>>> mediaPicker(
      BuildContext context) async {
    List<XFile> pickedMedia = [];

    try {
      pickedMedia = await ImagePicker().pickMultipleMedia();
    } catch (e) {
      debugPrint(e.toString());
    }
    if (pickedMedia.isNotEmpty) {
      Directory root = await getTemporaryDirectory();
      for (XFile asset in pickedMedia) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        Uint8List byteData = await asset.readAsBytes();

        final String mimType = asset.name.split('.').last;
        String directoryPath = root.path + '$fileName.$mimType';

        final file = File(directoryPath);
        await file.writeAsBytes(byteData);

        String? mediaType = lookupMimeType(file.path);

        Map<String, dynamic> mediaItem = {
          'filename': fileName, //optional
          'file': file,
          'filePath': directoryPath,
          'media_type': mediaType!.startsWith('image') ? 'Image' : 'Video',
          'mime_type': mimType,
          'fullPath': 'media/$fileName.$mimType',
          "width": '', //integer, required when media_type is Video
          "height": '',
          'size': await file.length(),
        };
        if (mediaType.startsWith('video')) {
          final videoInfo = FlutterVideoInfo();

          var info = await videoInfo.getVideoInfo(file.path);
          if (info != null) {
            mediaItem['width'] = info.width;
            mediaItem['height'] = info.height;
          }
        } else if (mediaType.startsWith('image')) {
          img.Image? image = img.decodeImage(await file.readAsBytes());
          if (image != null) {
            mediaItem['width'] = image.width;
            mediaItem['height'] = image.height;
          }
        }

        mediaList.add(mediaItem);
      }
    }

    AppFunctions.mediaList = mediaList;
    return mediaList;
  }

  static void showToast() {
    Fluttertoast.showToast(
      msg: 'Error happed please try again later',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.sp,
    );
  }

  static animateNavigation(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (ctx, animation, secondaryAnimation) {
          return const CreatePostScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static Future<void> onRefresh(BuildContext context) async {
    BlocProvider.of<PostBloc>(context)
        .add(const GetPostsEvent(isPagination: false));
  }
}
