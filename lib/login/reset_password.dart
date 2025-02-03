// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:edxera/login/Controllers/reset_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/login/login_empty_state.dart';

import '../utils/screen_size.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool ispassHiden = false;
  bool ispassHiden1 = false;
  ResetPasswordControllers controller = Get.put(ResetPasswordControllers());
  final formkey = GlobalKey<FormState>();

//ResetPasswordControllers
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      back_button(),
                      SizedBox(height: 20.h),
                      Center(
                        child: Text("Reset Password",
                            style: TextStyle(fontSize: 24.sp, fontFamily: 'Gilroy', color: Color(0XFF000000), fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: ListView(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text("Enter password which are different from the previous paswords.",
                                  style: TextStyle(color: Color(0XFF000000), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(height: 20.h),
                            passwordtextfield('Password'),
                            SizedBox(height: 20.h),
                            passwordtextfield1('Confirm password'),
                            SizedBox(height: 30),
                            done_button(),
                          ],
                        ),
                      ),
                    ],
                  ),
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

  toggle() {
    setState(() {
      ispassHiden = !ispassHiden;
    });
  }

  toggle1() {
    setState(() {
      ispassHiden1 = !ispassHiden1;
    });
  }

  Widget passwordtextfield(String i) {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: ispassHiden,
      decoration: InputDecoration(
          hintText: i,
          hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: EdgeInsets.only(left: 20.w),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: const Color(0XFF503494), width: 1.w)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: ispassHiden1
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
    );
  }

  Widget passwordtextfield1(String i) {
    return TextFormField(
      controller: controller.confirmController,
      obscureText: ispassHiden1,
      decoration: InputDecoration(
          hintText: i,
          hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: EdgeInsets.only(left: 20.w),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: const Color(0XFF503494), width: 1.w)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: ispassHiden1
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
    );
  }

  Widget back_button() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: Image(
          image: const AssetImage("assets/back_arrow.png"),
          height: 24.h,
          width: 24.w,
        ));
  }

  Widget done_button() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (formkey.currentState!.validate()) {
            if (controller.passwordController.value == controller.confirmController.value) {
              controller.forgotPassword();
            } else {
              Get.showSnackbar(
                GetSnackBar(
                  backgroundColor: Colors.red,
                  message: 'Please Check Password or Confirm Password Are Not Match',
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          }
        },
        //   showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //       backgroundColor: const Color(0XFFFFFFFF),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       actions: [
        //         Center(
        //           child: Padding(
        //             padding: EdgeInsets.only(left: 15.w, right: 15.w),
        //             child: Column(
        //               children: [
        //                 SizedBox(height: 20.h),
        //                 Image(
        //                   image: const AssetImage("assets/Privacy2.png"),
        //                   height: 88.13.h,
        //                   width: 76.33.w,
        //                 ),
        //                 SizedBox(height: 20.h),
        //                 Text(
        //                   "Changed !",
        //                   style: TextStyle(
        //                       fontSize: 22.sp,
        //                       fontFamily: 'Gilroy',
        //                       fontWeight: FontWeight.w700),
        //                 ),
        //                 SizedBox(height: 20.h),
        //                 Align(
        //                   //alignment: Alignment.centerRight,
        //                   child: Text(
        //                     "Your password has been changed sucessfully ! ",
        //                     style: TextStyle(
        //                         fontSize: 15.sp,
        //                         fontFamily: 'Gilroy',
        //                         fontWeight: FontWeight.bold),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                 ),
        //                 SizedBox(height: 20.h),
        //                 ok_button(),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ); // Navigator.push(context,//     MaterialPageRoute(builder: (context) => const()));
        // },
        child: Container(
          height: 56.h,
          width: 374.w,
          //color: Color(0XFF503494),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0XFF503494),
          ),
          child: Center(
            child: Text("Done", style: TextStyle(color: const Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }

  Widget ok_button() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Get.offAll(EmptyState());
          },
          child: Container(
            height: 56.h,
            width: 334.w,
            //color: Color(0XFF503494),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0XFF503494),
            ),
            child: Center(
              child: Text("Ok", style: TextStyle(color: const Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy')),
            ),
          ),
        ),
      ),
    );
  }
}
