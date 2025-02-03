// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:edxera/login/Controllers/forgot_password_controller.dart';
import 'package:edxera/login/PasswordOtpVerification/password_otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:edxera/login/reset_password.dart';

import '../utils/screen_size.dart';
import 'login_empty_state.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordControllers controller = Get.put(ForgotPasswordControllers());

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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    backbutton(),
                    Center(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 24.sp, fontFamily: 'Gilroy', color: const Color(0XFF000000), fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Enter your registered email to reset password.",
                                style: TextStyle(
                                    color: const Color(0XFF000000),
                                    fontSize: 15.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 54.h),
                          phone_number_field(),
                          SizedBox(height: 30.h),
                          submitbutton(),
                          // SizedBox(height: 151.h),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: back_login_button(),
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

  Widget submitbutton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          controller.forgotPassword();
          // Get.to(PasswordOtpVerification());
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
            child: Text("Submit", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }

  Widget back_login_button() {
    return Center(
      child: RichText(
          text: TextSpan(
              text: 'Back to login?',
              style: TextStyle(color: Colors.black, fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
              children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.off(const EmptyState());
                },
              text: ' Login',
              style: TextStyle(fontFamily: 'Gilroy', color: Color(0XFF000000), fontSize: 15.sp, fontWeight: FontWeight.w700),
            )
          ])),
    );
  }

  Widget phone_number_field() {
    return TextFormField(
      controller: controller.emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: const Color(0XFF9B9B9B), fontWeight: FontWeight.bold),
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
        if (val!.isEmpty)
          return 'Enter the  email';
        else {
          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
            return "Please enter valid email address";
          }
        }
        return null;
      },
    );

    // IntlPhoneField(
    //   decoration: InputDecoration(
    //       labelText: 'Phone Number',
    //       labelStyle: TextStyle(
    //           fontFamily: 'Gilroy',
    //           fontWeight: FontWeight.w700,
    //           fontSize: 15.sp,
    //           color: const Color(0XFF9B9B9B)),
    //       border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(12),
    //           borderSide:
    //               BorderSide(color: const Color(0XFFDEDEDE), width: 1.w)),
    //       focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(12),
    //           borderSide:
    //               BorderSide(color: const Color(0XFF503494), width: 1.w)),
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
    //         borderRadius: BorderRadius.circular(12),
    //       )),
    //   initialCountryCode: 'IN',
    //   onChanged: (phone) {
    //     print(phone.completeNumber);
    //   },
    // );
  }

  Widget backbutton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Image(
        image: const AssetImage("assets/back_arrow.png"),
        height: 24.h,
        width: 24.w,
      ),
    );
  }
}
