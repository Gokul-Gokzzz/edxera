import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/BatchDetailsScreen/batche_details_screen.dart';
import 'package:edxera/batchs/controllers/batch_main_controller.dart';
import 'package:edxera/utils/slider_page_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';
import 'Models/batches_list_data_model.dart';

class BatchesShowByCourseScreen extends StatefulWidget {
  final int count;

  const BatchesShowByCourseScreen({Key? key, required this.id, required this.count}) : super(key: key);
  final int id;

  @override
  State<BatchesShowByCourseScreen> createState() => _BatchesShowByCourseScreenState();
}

class _BatchesShowByCourseScreenState extends State<BatchesShowByCourseScreen> {
  BatchMainControleller ongoingCompletedController = Get.put(BatchMainControleller());
  PageController pageController = PageController();
  List ongoingCource = Utils.getOngoingCource();

  @override
  void initState() {
    ongoingCompletedController.batchListbycourseDataGets(widget.id);
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
      body: GetBuilder<OngoingCompletedController>(
        init: OngoingCompletedController(),
        builder: (controller) => Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: ListTile(
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        title: Text(
                          (widget.count > 1) ? mplanguage['batches'].toString() : mplanguage['viewbatche'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    //   search_text_field(),
                    ongoingCompletedController.batchesListDataModel.data != null
                        ? Expanded(
                            flex: 1,
                            child: PageView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: ongoingCompletedController.batchesListDataModel.data?.batches?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h, top: index == 0 ? 0.h : 10.h, left: 20.w, right: 20.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BatchesDetailScreen(
                                                requested:
                                                    (ongoingCompletedController.batchesListDataModel.data?.batches?[index].requestAcceptedStatus ?? 0)
                                                        .toString(),
                                                corcedetail: ongoingCompletedController.batchesListDataModel.data?.batches?[index].name ?? '',
                                                id: (ongoingCompletedController.batchesListDataModel.data?.batches?[index].id ?? 0).toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22.h),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                              ],
                                              color: Colors.white),
                                          child: Container(
                                            margin: EdgeInsets.all(15.w),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        (ongoingCompletedController.batchesListDataModel.data?.batches?[index].name ?? '')
                                                            .toUpperCase(),
                                                        maxLines: 5,
                                                        style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(height: 5.w),
                                                      Text(
                                                        (ongoingCompletedController.batchesListDataModel.data?.batches?[index].batchCode ?? '')
                                                            .toUpperCase(),
                                                        style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(height: 5.w),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Image(
                                                            image: const AssetImage("assets/gridview3.png"),
                                                            height: 24.h,
                                                            width: 24.w,
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          Text(
                                                            ongoingCompletedController.batchesListDataModel.data?.batches?[index].days ?? '',
                                                            style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image(
                                                          image: const AssetImage("assets/right_arrow.png"),
                                                          height: 24.h,
                                                          width: 24.w,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              if (ongoingCompletedController.isloader.value)
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
          ),
          // ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget search_text_field() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
          prefixIcon: const Image(
            image: AssetImage('assets/search.png'),
            height: 24,
            width: 24,
          ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
        )),
      ),
    );
  }
}
