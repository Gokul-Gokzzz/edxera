import 'dart:collection';

import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/Models/home_categories_model.dart';
import 'package:edxera/languagecontrols/LanguageCheck.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'course_list_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final Category category;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  Map<String, dynamic> mplanguage = new HashMap();
  HomeController homecontroller = Get.put(HomeController());

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
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
              child: ListView.builder(
                  itemCount: widget.category.subCategories?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: index == 0 ? 0.h : 8.h, bottom: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(CourseListScreen(category: widget.category.subCategories![index]));
                        },
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.h),
                              boxShadow: [
                                BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                              ],
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              "${widget.category.subCategories?[index].title}",
                              style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
