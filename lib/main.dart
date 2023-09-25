import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yawar_task/presentation/controller/blocs/post_bloc/post_bloc.dart';
import 'package:yawar_task/presentation/controller/blocs/post_bloc/post_event.dart';
import 'package:yawar_task/presentation/controller/cubits/media_cubit.dart';
import 'package:yawar_task/presentation/screens/create_post_screen.dart';
import 'package:yawar_task/presentation/screens/posts_screen.dart';

import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (BuildContext context) => sl<PostBloc>()
                    ..add(
                      const GetPostsEvent(isPagination: false),
                    ),
                  child: const CreatePostScreen(),
                ),
                BlocProvider(
                  create: (
                    BuildContext context,
                  ) =>
                      sl<MediaCubit>(),
                  child: const CreatePostScreen(),
                ),
              ],
              child: const MaterialApp(
                  debugShowCheckedModeBanner: false, home: MainScreen()));
        });
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostsScreen();
  }
}
