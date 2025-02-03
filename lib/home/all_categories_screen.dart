import 'dart:collection';
import 'dart:io';

import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/sub_categories_screen.dart';
import 'package:edxera/languagecontrols/LanguageCheck.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  Map<String, dynamic> mplanguage = new HashMap();
  HomeController homecontroller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await homecontroller.homeCategoryDataGetApi();
      },
    );
  }

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            SafeArea(
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
                        Text(mplanguage['all_categories'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp, fontFamily: 'Gilroy'), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: homecontroller.categoriesData.value.data?.categories?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: index == 0 ? 0.h : 8.h, bottom: 8.h),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(SubCategoriesScreen(
                                    category: homecontroller.categoriesData.value.data!.categories![index],
                                  ));
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
                                      "${homecontroller.categoriesData.value.data?.categories?[index].title}",
                                      style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                  ),
                ],
              ),
            ),
            if (homecontroller.isloader.value)
              SafeArea(
                top: false,
                bottom: false,
                child: ColoredBox(
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
                ),
              ),
          ],
        );
      }),
    );
  }
}
