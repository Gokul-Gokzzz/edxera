import 'dart:io';

import 'package:edxera/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edxera/utils/slider_page_data_model.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  ContactusController helpCenterController = Get.put(ContactusController());

  @override
  void initState() {
    helpCenterController.contactListDataApi();
    super.initState();
  }

  List contect = Utils.getContect();
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Obx(
      () => Stack(
        children: [
          helpCenterController.contactUsDataModel.data != null
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 20.w, left: 20.w),
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            boxShadow: [
                              BoxShadow(color: Color(0XFF503494).withOpacity(0.14), offset: Offset(-4, 5), blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(contect[0].contectIcon),
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                helpCenterController.contactUsDataModel.data?.details?.customerService ?? '',
                                style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 20.w, left: 20.w),
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            boxShadow: [
                              BoxShadow(color: Color(0XFF503494).withOpacity(0.14), offset: Offset(-4, 5), blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(contect[1].contectIcon),
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                helpCenterController.contactUsDataModel.data?.details?.website ?? '',
                                style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 20.w, left: 20.w),
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            boxShadow: [
                              BoxShadow(color: Color(0XFF503494).withOpacity(0.14), offset: Offset(-4, 5), blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(contect[2].contectIcon),
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                helpCenterController.contactUsDataModel.data?.details?.whatsapp ?? '',
                                style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 20.w, left: 20.w),
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            boxShadow: [
                              BoxShadow(color: Color(0XFF503494).withOpacity(0.14), offset: Offset(-4, 5), blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(contect[3].contectIcon),
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                helpCenterController.contactUsDataModel.data?.details?.facebook ?? '',
                                style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 20.w, left: 20.w),
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            boxShadow: [
                              BoxShadow(color: Color(0XFF503494).withOpacity(0.14), offset: Offset(-4, 5), blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(contect[4].contectIcon),
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                helpCenterController.contactUsDataModel.data?.details?.instagram ?? '',
                                style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
          if (helpCenterController.isloader.value)
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
    );
  }
}
