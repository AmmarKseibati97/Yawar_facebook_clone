import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPostComponent extends StatelessWidget {
  const LoadingPostComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      itemExtent: 0.3.sh,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.all(10.h),
            child: Container(
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
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.08.sh,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 28.w,
                            ),
                            title: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.sp)),
                              height: 20.h,
                            ),
                            subtitle: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.sp)),
                              height: 20.h,
                            ),
                          ),
                        )
                      ],
                    ))));
      },
    );
  }
}
