import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';
import 'ContactUs.dart';
import 'faq_screen_page.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  PageController pageController = PageController();
  int initialValue = 1;
  HelpCenterController helpCenterController = Get.put(HelpCenterController());
  List helpCenter = [FAQScreen(), ContactUsScreen()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
  }

  Map<String, dynamic> mplanguage = new HashMap();

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
        body: GetBuilder<HelpCenterController>(
      init: HelpCenterController(),
      builder: (controller) => Column(
        children: [
          SizedBox(height: 70.h),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image(
                      image: AssetImage("assets/back_arrow.png"),
                      height: 24.h,
                      width: 24.h,
                    )),
              ),
              SizedBox(width: 15.h),
              Text(
                mplanguage['helpcenter'].toString(),
                style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Gilroy', fontSize: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 54.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.h),
                  boxShadow: [
                    BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                  ],
                  color: Colors.white),
              child: TabBar(
                unselectedLabelColor: Color(0XFF6E758A),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                labelStyle: TextStyle(color: const Color(0XFF503494), fontWeight: FontWeight.bold, fontSize: 13.sp, fontFamily: 'Gilroy'),
                labelColor: const Color(0XFF503494),
                unselectedLabelStyle: TextStyle(color: const Color(0XFF503494), fontWeight: FontWeight.w700, fontSize: 13.sp, fontFamily: 'Gilroy'),
                indicator: ShapeDecoration(color: const Color(0XFFE5ECFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.h))),
                controller: helpCenterController.tabController,
                tabs: [
                  Tab(
                    text: mplanguage['faq'].toString(),
                  ),
                  Tab(
                    text: mplanguage['contactus'].toString(),
                  ),
                ],
                onTap: (value) {
                  helpCenterController.pController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                },
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: helpCenterController.pController,
              onPageChanged: (value) {
                helpCenterController.tabController.animateTo(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
              // controller: helpCenterController.tabController,
              itemCount: helpCenter.length,
              itemBuilder: (context, index) {
                return helpCenter[index];
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
