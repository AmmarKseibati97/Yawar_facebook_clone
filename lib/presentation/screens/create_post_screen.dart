import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yawar_task/core/utils/app_constances/app_functions.dart';
import 'package:yawar_task/core/utils/enums.dart';

import '../components/create_post_components/create_post_media_component.dart';
import '../controller/blocs/post_bloc/post_bloc.dart';
import '../controller/blocs/post_bloc/post_event.dart';
import '../controller/blocs/post_bloc/post_state.dart';
import '../controller/cubits/media_cubit.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController content = TextEditingController();

  @override
  void dispose() {
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.watch<MediaCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          iconSize: 36.sp,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        leadingWidth: 0.08.sw,
        title: const Text(
          "Create Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(6.w),
            child: MaterialButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<PostBloc>(context).add(CreatePostEvent(
                    context: context,
                    content: content.value.text,
                    mediaList: AppFunctions.mediaList));
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp)),
              child: const Text(
                "POST",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0.h),
            child: Column(
              children: [
                SizedBox(
                  height: 0.3.sh,
                  child: TextField(
                    style: TextStyle(fontSize: 28.sp),
                    controller: content,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(fontSize: 28.sp),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40.0.sp),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 0.5.sp),
                      bottom: BorderSide(color: Colors.black, width: 0.5.sp),
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      requestStoragePermission();
                      final mediaList = await AppFunctions.mediaPicker(context);
                      mediaCubit.loadMedia(mediaList);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_library,
                          color: Colors.green,
                          size: 30.sp,
                        ),
                        SizedBox(width: 0.05.sw),
                        const Text(
                          "Photo/video",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<MediaCubit, MediaState>(
                    builder: (context, state) {
                      if (state == MediaState.success) {
                        return CreatePostMediaComponent(
                          media: mediaCubit.mediaList,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state.createPostState == RequestState.loading) {
                return Container(
                    color: Colors.black45,
                    height: ScreenUtil().screenHeight,
                    width: ScreenUtil().screenWidth,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> requestStoragePermission() async {
    final PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      debugPrint('status.isGranted');
    } else if (status.isDenied) {
      debugPrint('status.isDenied');
    } else if (status.isPermanentlyDenied) {
      debugPrint('status.isPermanentlyDenied');

      openAppSettings();
    }
  }
}
