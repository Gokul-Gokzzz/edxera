import 'dart:collection';
import 'dart:io';

import 'package:edxera/profile/Controllers/change_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/shared_pref.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool ispassHiden = true;
  bool ispassNewHiden = true;
  bool ispassConfHiden = true;
  ChangePasswordController controller = Get.put(ChangePasswordController());
  final formkey = GlobalKey<FormState>();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // leading: GestureDetector(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: Image(
        //     image: AssetImage("assets/back_arrow.png"),
        //     height: 22.h,
        //     width: 22.w,
        //   ),
        // ),
        centerTitle: false,
        title: Text(
          mplanguage['changepassword'].toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: ispassHiden,
                      decoration: InputDecoration(
                          hintText: mplanguage['oldpassword'].toString(),
                          hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0XFF503494), width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          contentPadding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
                          suffixIcon: ispassHiden
                              ? GestureDetector(
                                  onTap: () => toggle(),
                                  child: Image(
                                    image: const AssetImage("assets/notvisible_eye.png"),
                                    height: 20.h,
                                    width: 20.w,
                                  ))
                              : GestureDetector(
                                  onTap: () => toggle(),
                                  child: Image(
                                    image: const AssetImage("assets/visible_eye.png"),
                                    height: 20.h,
                                    width: 20.w,
                                  ))),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter The Old Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: controller.newController,
                      obscureText: ispassNewHiden,
                      decoration: InputDecoration(
                          hintText: mplanguage['newpassword'].toString(),
                          hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0XFF503494), width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          contentPadding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
                          suffixIcon: ispassNewHiden
                              ? GestureDetector(
                                  onTap: () => toggle1(),
                                  child: Image(
                                    image: const AssetImage("assets/notvisible_eye.png"),
                                    height: 20.h,
                                    width: 20.w,
                                  ))
                              : GestureDetector(
                                  onTap: () => toggle1(),
                                  child: Image(
                                    image: const AssetImage("assets/visible_eye.png"),
                                    height: 20.h,
                                    width: 20.w,
                                  ))),
                      validator: (val) {
                        if (val!.isEmpty) {
                          if (controller.passwordController.text == controller.confirmController) {
                            return 'Old Password and New Password are match';
                          }
                          return 'Enter The New Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: controller.confirmController,
                      obscureText: ispassConfHiden,
                      decoration: InputDecoration(
                          hintText: mplanguage['confirmpassword'].toString(),
                          hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0XFF503494), width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          contentPadding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
                          suffixIcon: ispassConfHiden
                              ? GestureDetector(
                                  onTap: () => toggle2(),
                                  child: Image(
                                    image: const AssetImage("assets/notvisible_eye.png"),
                                    height: 20.h,
                                    width: 20.w,
                                  ))
                              : GestureDetector(
                                  onTap: () => toggle2(),
                                  child: Image(
                                    image: const AssetImage("assets/visible_eye.png"),
                                    height: 20.h,
                                    width: 20.w,
                                  ))),
                      validator: (val) {
                        if (val!.isEmpty) {
                          if (controller.newController.text != controller.confirmController) {
                            return 'Password are not match';
                          }
                          return 'Enter The Confirm Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
                    loginbutton(),
                  ],
                ),
              ),
            ),
            if (controller.isloader.value)
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

  Widget loginbutton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (formkey.currentState!.validate()) {
            controller.changePasswordApi();

            //PrefData.setVarification(true);
          }
        },
        child: Container(
          height: 56.h,
          width: 374.w,
          //color: Color(0XFF503494),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0XFF503494),
          ),
          child: Center(
            child: Text(mplanguage['submit'].toString(),
                style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }

  toggle() {
    setState(() {
      ispassHiden = !ispassHiden;
    });
  }

  toggle1() {
    setState(() {
      ispassNewHiden = !ispassNewHiden;
    });
  }

  toggle2() {
    setState(() {
      ispassConfHiden = !ispassConfHiden;
    });
  }
}
