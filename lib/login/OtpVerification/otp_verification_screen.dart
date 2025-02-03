import 'package:edxera/home/home_main.dart';
import 'package:edxera/login/login_empty_state.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final otpkey = GlobalKey<FormState>();
  String otp = '0';
  //RegisterControllers controller = Get.put(RegisterControllers());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              backbutton(),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Verification",
                  style: TextStyle(fontSize: 24.sp, fontFamily: 'Gilroy', color: Color(0XFF000000), fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "The Verification Code Please Enter 1234",
                        style: TextStyle(color: Color(0XFF000000), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    otpformat(),
                    SizedBox(height: 30.h),
                    Confirmbutton(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: resend_otp_button(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget otpformat() {
    return Form(
      key: otpkey,
      child: OtpTextField(
        numberOfFields: 4,
        borderColor: const Color(0xFFDEDEDE),
        showFieldAsBox: true,
        borderRadius: BorderRadius.circular(12),
        borderWidth: 1,
        focusedBorderColor: Color(0XFF503494),
        fieldWidth: 79.w,
        onSubmit: (value) {
          otp = value;
          setState(() {});

          //controller.otp.value = value;
        },
      ),
    );
  }

  Widget backbutton() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back_ios, color: Color(0XFF000000)));
  }

  Widget Confirmbutton() {
    return Center(
        child: GestureDetector(
      onTap: () {
        if (otp == '1234') {
          PrefData.setLogin(true);
          Get.offAll(const HomeMainScreen());
        } else {
          Fluttertoast.showToast(
              msg: "Please enter the Valid OTP",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0.sp);
        }

        // print("otp length ${controller.otp.value.length}");
        // controller.otp.value != ''
        //     ? controller.verificationCodeApi(widget.emailid)
        //     : Fluttertoast.showToast(
        //         msg: "Please enter the OTP",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.CENTER,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Colors.red,
        //         textColor: Colors.white,
        //         fontSize: 16.0.sp);

        // Navigator.
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
          child:
              Text("Confirm", style: TextStyle(color: const Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy')),
        ),
      ),
    ));
  }

  Widget resend_otp_button() {
    return Center(
      child: RichText(
          text: TextSpan(text: 'Don’t receive code?', style: TextStyle(color: Colors.black, fontSize: 15.sp, fontFamily: 'Gilroy'), children: [
        TextSpan(
          recognizer: TapGestureRecognizer()..onTap = () {},
          text: ' Resend',
          style: TextStyle(fontFamily: 'Gilroy', color: Color(0XFF000000), fontSize: 15.sp, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal),
        )
      ])),
    );
  }
}
