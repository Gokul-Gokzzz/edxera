import 'dart:collection';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  EditScreenController editScreenController = Get.put(EditScreenController());

  @override
  void initState() {
    editScreenController.userDataApi();
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
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Stack(
          children: [
            GetBuilder(
              init: EditScreenController(),
              builder: (editScreenController) => SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: editScreenController.userDataModel.data != null
                      ? Column(
                          children: [
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(Icons.arrow_back_ios)),
                                SizedBox(width: 16.w),
                                Text(
                                  mplanguage['edit_profile'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp, fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.h / 2),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 100.h,
                                width: 100.w,
                                imageUrl: editScreenController.userDataModel.data?.image ?? '',
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
                                    height: 100.h,
                                    width: 100.w,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(height: 30.h),
                                  name_email_phone(
                                    editScreenController.nameController,
                                    "assets/profileicon1st.png",
                                    mplanguage['entername'].toString(),
                                  ),
                                  SizedBox(height: 20.h),
                                  name_email_phone(
                                    editScreenController.emailController,
                                    "assets/profileicon2nd.png",
                                    mplanguage['enteremailid'].toString(),
                                  ),
                                  SizedBox(height: 20.h),
                                  name_email_phone(
                                    editScreenController.passwordController,
                                    "assets/profileicon3rd.png",
                                    mplanguage['enterph'].toString(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 40.h),
                              child: save_button(),
                            )
                          ],
                        )
                      : Container(),
                ),
              ),
            ),
            if (editScreenController.isloader.value)
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
      ),
    );
  }

  name_email_phone(
    TextEditingController controller,
    String i,
    h,
  ) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: [
            BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
          ],
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: h,
            contentPadding: EdgeInsets.only(left: 18.w, top: 18.h, bottom: 18.h),
            prefixIcon: Padding(
              padding: EdgeInsets.all(7.0.h),
              child: Container(
                //color: Colors.red,
                height: 24.h,
                width: 24.h,
                child: Image(
                  image: AssetImage(i),
                ),
              ),
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 15.sp, color: Color(0XFF6E758A), fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  save_button() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
        child: Container(
          height: 56.h,
          width: 374.w,
          //color: Color(0XFF503494),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: const Color(0XFF503494),
          ),
          child: Center(
            child: Text(mplanguage['save'].toString(),
                style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }
}
