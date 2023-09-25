import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yawar_task/core/utils/app_constances/app_functions.dart';
import 'package:yawar_task/core/utils/enums.dart';
import 'package:yawar_task/presentation/components/posts_screen_components/loading_posts_component.dart';

import '../components/posts_screen_components/post_component.dart';
import '../controller/blocs/post_bloc/post_bloc.dart';
import '../controller/blocs/post_bloc/post_event.dart';
import '../controller/blocs/post_bloc/post_state.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts Screen"),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () => AppFunctions.onRefresh(context),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        width: 0.8.sw,
                        height: 0.05.sh,
                        child: TextField(
                          showCursor: false,
                          readOnly: true,
                          onTap: () {
                            AppFunctions.animateNavigation(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'What\'s on your mind?',
                            contentPadding: EdgeInsets.all(
                              15.0.h,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.1.sp),
                              borderRadius: BorderRadius.circular(40.0.sp),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.1.sp),
                              borderRadius: BorderRadius.circular(40.0.sp),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.1.sp),
                              borderRadius: BorderRadius.circular(40.0.sp),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          iconSize: 28.sp,
                          onPressed: () {
                            AppFunctions.animateNavigation(context);
                          },
                          icon: const Icon(
                            Icons.photo_library,
                            color: Colors.green,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.82.sh,
                  child: BlocConsumer<PostBloc, PostState>(
                    listener: (context, state) {
                      _scrollController.addListener(() {
                        if (state.postsState != RequestState.loading &&
                            _scrollController.position.pixels ==
                                _scrollController.position.maxScrollExtent) {
                          BlocProvider.of<PostBloc>(context)
                              .add(const GetPostsEvent(isPagination: true));
                        }
                      });
                    },
                    buildWhen: (previous, current) =>
                        previous.postsState != current.postsState ||
                        previous.posts.length != current.posts.length,
                    builder: (context, state) {
                      switch (state.postsState) {
                        case RequestState.loaded:
                          final data = state.posts;

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.posts.length,
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.h),
                                child: PostComponent(
                                  media: data[index].media,
                                  postDescription: data[index].content!,
                                  hasImage: data[index].hasMedia,
                                  reactions: data[index].interactionsCountTypes,
                                  commentsCount: data[index].commentsCount,
                                  postTime: data[index].createdAt,
                                  userName: data[index].model.name,
                                ),
                              );
                            },
                          );
                        case RequestState.loading:
                          return const LoadingPostComponent();

                        case RequestState.error:
                          return Center(
                            child: Text(state.postsMessage),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
