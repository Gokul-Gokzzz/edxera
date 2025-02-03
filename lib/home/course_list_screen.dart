import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/Models/home_categories_model.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../cources/cources.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key, required this.category});

  final Category category;

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await homeController.categoryDetailGetApi(id: widget.category.id.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (homeController.isloader.value) {
            return ColoredBox(
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        spreadRadius: 0.1,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  height: 80,
                  width: 80,
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator(
                          animating: true,
                          color: Color(0XFF503494),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(25),
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                            color: Color(0XFF503494),
                          ),
                        ),
                ),
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image(
                            image: const AssetImage("assets/back_arrow.png"),
                            height: 24.h,
                            width: 24.w,
                          )),
                      SizedBox(width: 15.w),
                      Text("${widget.category.title}",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp, fontFamily: 'Gilroy'), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Obx(() {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: (homeController.categoriesDetailsData.value.data?.courses == null ||
                              homeController.categoriesDetailsData.value.data?.courses?.isEmpty == true)
                          ? Center(
                              child: Text(
                                "No Data Found",
                                style: TextStyle(color: Color(0XFF503494), fontSize: 20.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                              ),
                            )
                          : GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              physics: const BouncingScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: homeController.categoriesDetailsData.value.data?.courses?.length,
                              itemBuilder: (BuildContext context, index) {
                                var course = homeController.categoriesDetailsData.value.data?.courses;
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => MyCources(), arguments: course?[index].id ?? 0);
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150.h,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              // height: 50.h,
                                              // width: 50.w,
                                              imageUrl: '${ApiConstants.publicBaseUrl}/${course?[index].courseThumbnail ?? ''}',
                                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                                child: Container(
                                                  height: 30.h,
                                                  width: 30.w,
                                                  child: CircularProgressIndicator(value: downloadProgress.progress),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) => ClipRRect(
                                                borderRadius: BorderRadius.circular(10.h),
                                                child: Container(
                                                  // height: 50.h,
                                                  // width: 50.w,
                                                  color: Colors.grey.withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          course?[index].title ?? '',
                                          maxLines: 5,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13.sp,
                                            color: const Color(0XFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    );
                  }),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
