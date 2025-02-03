import 'dart:io';

import 'package:edxera/login/Controllers/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/login/login_empty_state.dart';
import 'package:edxera/login/sign_up/term_and_condition.dart';

import '../../utils/screen_size.dart';

class SignInEmptyScreen extends StatefulWidget {
  const SignInEmptyScreen({Key? key}) : super(key: key);

  @override
  State<SignInEmptyScreen> createState() => _SignInEmptyScreenState();
}

class _SignInEmptyScreenState extends State<SignInEmptyScreen> {
  bool ischeaked = false;
  bool ispassHiden = true;
  bool ispassHiden1 = true;

  String passworderror = '';
  final formkey = GlobalKey<FormState>();
  RegisterControllers controller = Get.put(RegisterControllers());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h),
                  back_button(),
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      "Create an account",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp, fontFamily: 'Gilroy', color: const Color(0XFF000000)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //  SizedBox(height: 20.h),
                  Expanded(
                    child: ListView(
                      children: [
                        detailform(),
                        SizedBox(height: 25.h),
                        term_condition_cheakbox(),
                        SizedBox(height: 25.h),
                        sign_up_button(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: already_login_button(),
                  ),
                  //Checkbox
                ],
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

  Widget detailform() {
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(
              hintText: 'Name',
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
              if (val!.isEmpty) return 'Enter the  Name';
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextField(
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
            // validator: (val) {
            //   if (val!.isEmpty)
            //     return 'Enter the  email';
            //   else {
            //     if (!RegExp(
            //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            //         .hasMatch(val)) {
            //       return "Please enter valid email address";
            //     }
            //   }
            //   return null;
            // },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: controller.phoneNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Phone',
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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (val) {
              if (val!.isEmpty) {
                return 'Enter the  Phone Number';
              }
              // Regex to match only digits
              final regex = RegExp(r'^[0-9]+$');
              if (!regex.hasMatch(val)) {
                return 'Enter a valid Phone Number';
              }

              return null;
            },
          ),
          // SizedBox(height: 20.h),
          // TextFormField(
          //   controller: controller.passwordController,
          //   obscureText: ispassHiden,
          //   decoration: InputDecoration(
          //     suffixIcon: ispassHiden
          //         ? GestureDetector(
          //             onTap: () => toggle(),
          //             child: Image(
          //               image: const AssetImage("assets/notvisible_eye.png"),
          //               height: 20.h,
          //               width: 20.w,
          //             ))
          //         : GestureDetector(
          //             onTap: () => toggle(),
          //             child: Image(
          //               image: const AssetImage("assets/visible_eye.png"),
          //               height: 20.h,
          //               width: 20.w,
          //             )),
          //     hintText: 'Password',
          //     hintStyle: const TextStyle(
          //         fontSize: 15,
          //         fontFamily: 'Gilroy',
          //         color: Color(0XFF9B9B9B),
          //         fontWeight: FontWeight.bold),
          //     border: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(color: const Color(0XFF503494), width: 1.w),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     filled: true,
          //     fillColor: const Color(0xFFF5F5F5),
          //     contentPadding:
          //         EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
          //   ),
          //   validator: (val) {
          //     if (val!.isEmpty) return 'Enter the  password';
          //     return null;
          //   },
          // ),
          // SizedBox(height: 20.h),
          // TextFormField(
          //   controller: controller.confirmpassController,
          //   obscureText: ispassHiden1,
          //   decoration: InputDecoration(
          //     suffixIcon: ispassHiden1
          //         ? GestureDetector(
          //             onTap: () => toggle1(),
          //             child: Image(
          //               image: const AssetImage("assets/notvisible_eye.png"),
          //               height: 20.h,
          //               width: 20.w,
          //             ))
          //         : GestureDetector(
          //             onTap: () => toggle1(),
          //             child: Image(
          //               image: const AssetImage("assets/visible_eye.png"),
          //               height: 20.h,
          //               width: 20.w,
          //             )),
          //     hintText: 'Confirm password',
          //     hintStyle: TextStyle(
          //         fontSize: 15.sp,
          //         fontFamily: 'Gilroy',
          //         color: const Color(0XFF9B9B9B),
          //         fontWeight: FontWeight.bold),
          //     border: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(color: const Color(0XFF503494), width: 1.w),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide:
          //           BorderSide(color: const Color(0XFFDEDEDE), width: 1.w),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     filled: true,
          //     fillColor: const Color(0xFFF5F5F5),
          //     contentPadding:
          //         EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
          //   ),
          //   validator: (val) {
          //     if (val!.isEmpty) return 'Enter the confirm password';
          //
          //     return null;
          //   },
          // ),
        ],
      ),
    );
  }

  Widget term_condition_cheakbox() {
    return Row(
      children: [
        Checkbox(
          activeColor: const Color(0XFF503494),
          side: const BorderSide(color: Color(0XFFDEDEDE)),
          value: ischeaked,
          onChanged: (value) {
            setState(() {
              ischeaked = value!;
            });
          },
        ),
        RichText(
            text: TextSpan(
                text: 'I Agree with ',
                style: TextStyle(color: Colors.black, fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(const TermCondition());
                  },
                text: 'Terms and condition',
                style: const TextStyle(color: Color(0XFF503494), fontSize: 17, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
              )
            ])),
      ],
    );
  }

  Widget sign_up_button() {
    return Container(
      height: 56.h,
      width: 374.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFF503494),
      ),
      child: TextButton(
        onPressed: () {
          if (formkey.currentState!.validate()) {
            if (ischeaked) {
              //Get.to(const SignInPhonenumber());

              controller.loginApi();
            } else {
              Get.showSnackbar(
                GetSnackBar(
                  backgroundColor: Colors.red,
                  message: 'Please Select Terms & Conditions',
                  duration: const Duration(seconds: 1),
                ),
              );
            }
            // if (controller.confirmpassController.value ==
            //     controller.passwordController.value) {
            //
            // } else {
            //   Get.showSnackbar(
            //     GetSnackBar(
            //       backgroundColor: Colors.red,
            //       message:
            //           'Please Check Password or Confirm Password Are Not Match',
            //       duration: const Duration(seconds: 1),
            //     ),
            //   );
            // }
          }
        },
        child: Text("Sign Up", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy')),
      ),
    );
  }

  Widget already_login_button() {
    return InkWell(
      onTap: () {
        Get.off(const EmptyState());
        ;
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
              text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp, fontFamily: 'Gilroy'),
                  children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                )
              ])),
        ),
      ),
    );
  }

  Widget back_button() {
    return InkWell(
        onTap: () {
          Navigator.pop(context, true);
        },
        child: Image(
          image: const AssetImage("assets/back_arrow.png"),
          height: 24.h,
          width: 24.w,
        ));
  }

  @override
  void dispose() {
    controller.nameController.dispose();
    controller.emailController.dispose();
    // controller.passwordController.dispose();
    // controller.confirmpassController.dispose();
    super.dispose();
  }
}
