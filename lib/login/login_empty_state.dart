// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:edxera/login/Controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/login/forgot_password.dart';
import 'package:edxera/login/sign_up/sign_up_empty_screen.dart';
import '../utils/screen_size.dart';

class EmptyState extends StatefulWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  final formkey = GlobalKey<FormState>();
  bool ispassHiden = false;
  LoginControllers controller = Get.put(LoginControllers());

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // InkWell(
                    //     onTap: () {
                    //       Navigator.pop(exit(0));
                    //     },
                    //     child: Image(
                    //       image: const AssetImage("assets/back_arrow.png"),
                    //       height: 24.h,
                    //       width: 24.w,
                    //     )),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp, fontFamily: 'Gilroy', color: Color(0XFF000000)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Center(
                              child: Text(
                            "Glad to meet you again!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0XFF000000),
                                fontSize: 15.sp,
                                fontFamily: 'Gilroy',
                                fontStyle: FontStyle.normal),
                            textAlign: TextAlign.center,
                          )),
                          SizedBox(height: 10.h),
                          email_password_form(),
                          SizedBox(height: 21.h),
                          forgotpassword(),
                          SizedBox(height: 40.h),
                          loginbutton(),
                          SizedBox(height: 40.h),
                          //  or_sign_in_with_text(),
                          //SizedBox(height: 41.h),
                          //login_google(),
                          //  SizedBox(height: 20.h),
                          //login_facebook(),
                          //SizedBox(height: 97.h),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: sign_up(),
                    ),
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

  toggle() {
    setState(() {
      ispassHiden = !ispassHiden;
    });
  }

  Widget forgotpassword() {
    return GestureDetector(
      onTap: () {
        Get.to(const ForgotPassword());
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Forgot password ?",
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
            color: Color(0XFF503494),
          ),
        ),
      ),
    );
  }

  Widget loginbutton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (formkey.currentState!.validate()) {
            controller.loginApi();

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
            child: Text("Log In", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }

  Widget login_google() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.h,
        width: 374.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.withOpacity(0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/google.png")),
            SizedBox(width: 10.w),
            Text(
              "Login with Google",
              style: TextStyle(color: Color(0XFF000000), fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget login_facebook() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.h,
        width: 374.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.withOpacity(0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/facebook.png")),
            SizedBox(width: 10.w),
            Text(
              "Login with Facebook",
              style: TextStyle(color: const Color(0XFF000000), fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget sign_up() {
    return InkWell(
      onTap: () {
        Get.to(const SignInEmptyScreen());
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
          child: RichText(
              text:
                  TextSpan(text: 'Don\'t have an account?', style: TextStyle(color: Colors.white, fontSize: 15.sp, fontFamily: 'Gilroy'), children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(const SignInEmptyScreen());
                },
              text: ' Sign up',
              style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
            )
          ])),
        ),
      ),
    );
  }

  Widget or_sign_in_with_text() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 0.h,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: const Color(0XFFDEDEDE),
          ),
        ),
        GestureDetector(
          child: Text("OR Sign in with",
              style: TextStyle(
                  color: const Color(0XFF000000), fontSize: 15.sp, fontWeight: FontWeight.w400, fontFamily: 'Gilroy', fontStyle: FontStyle.normal)),
        ),
        Expanded(
          child: Divider(
            height: 0.h,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: const Color(0XFFDEDEDE),
          ),
        )
      ],
    );
  }

  Widget email_password_form() {
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(
              hintText: 'Email or phone number',
              hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.w700),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
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
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Enter the email or phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 15.h),
          TextFormField(
            controller: controller.passwordController,
            obscureText: ispassHiden,
            decoration: InputDecoration(
                hintText: 'Password',
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
                return 'Enter the  password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
