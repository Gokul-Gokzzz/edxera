import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/languagecontrols/LanguageCheck.dart';
import 'package:edxera/profile/Controllers/change_password_controller.dart';
import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
import 'package:edxera/profile/change_password_screen.dart';
import 'package:edxera/profile/language_selection.dart';
import 'package:edxera/profile/my_payment_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/profile/edit_screen.dart';
import 'package:edxera/profile/feedback.dart';
import 'package:edxera/profile/help_center.dart';
import 'package:edxera/profile/my_certification.dart';
import 'package:edxera/profile/my_project.dart';
import 'package:edxera/profile/privacy_policy.dart';
import 'package:edxera/profile/rate_us.dart';
import 'package:edxera/profile/saved_cource.dart';
import 'package:edxera/utils/slider_page_data_model.dart';

import '../controller/controller.dart';
import '../login/login_empty_state.dart';
import '../models/profile_option.dart';
import '../repositories/api/api_constants.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';
import 'certi_payment.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  MyProfileController myProfileController = Get.put(MyProfileController());
  List<ProfileOption> profileoption = Utils.getProfileOption();
  Map<String, dynamic> mplanguage = new HashMap();
  List profileOptionClass = [
    MyCertification(),
    //MyProject(),
    MyPaymentDetails(),
    SavedCourse(),
    CertificatePayment(),
    ChangePasswordScreen(),
    HelpCenter(),
    PrivacyPolicyScreen(),

    FeedBack(),
    LanguageSelection(),
    RateUs(),
  ];
  ChangePasswordController _changePasswordController = Get.put(ChangePasswordController());

  // Future<bool> rateUsDialog() async {
  //   return await Get.defaultDialog(
  //
  //   ).then((value) => value ?? false);
  // }

  @override
  void initState() {
    myProfileController.userDataApi();

    super.initState();
    checkLanguage();
  }

  final UserProfileController userProfileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            GetBuilder(
              id: 'UserData',
              init: MyProfileController(),
              builder: (MyProfileController) => myProfileController.userDataModel.data != null
                  ? SafeArea(
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                // GestureDetector(
                                //     onTap: () {
                                //       SystemChannels.platform
                                //           .invokeMethod('SystemNavigator.pop');
                                //     },
                                //     child: Image(
                                //       image: AssetImage("assets/back_arrow.png"),
                                //       height: 24.h,
                                //       width: 24.w,
                                //     )),
                                // SizedBox(width: 15.w),
                                Text(
                                  mplanguage['myprofile'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp, fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.h / 2),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 100.h,
                              width: 100.w,
                              imageUrl: "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
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
                          SizedBox(height: 12.h),
                          Text(
                            myProfileController.userDataModel.data?.name ?? '',
                            style: TextStyle(fontSize: 18.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700, color: const Color(0XFF000000)),
                          ),
                          SizedBox(height: 2.h),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(mplanguage['edit_profile'].toString(),
                                    style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400, color: Color(0XFF000000))),
                                Image(
                                  image: AssetImage("assets/editsymbol.png"),
                                  height: 16.h,
                                  width: 16.w,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView(
                              primary: true,
                              shrinkWrap: false,
                              children: [
                                ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: profileoption.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h, top: index == 0 ? 0.h : 10.h, left: 20.w, right: 20.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          if ((index == profileOptionClass.length)) {
                                            //
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(mplanguage['deleteaccount'].toString()),
                                                  content: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(mplanguage['deleteinfo'].toString()),
                                                        // TextField(
                                                        //   controller: _textFieldController,
                                                        //   decoration: InputDecoration(
                                                        //       hintText:
                                                        //           "Enter Register Email Id"),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(mplanguage['cancel'].toString()),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                        child: Text(
                                                          mplanguage['delete'].toString(),
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          _changePasswordController.delteAccountApi();
                                                        }
                                                        // print(_textFieldController.text);
                                                        // Navigator.pop(context);

                                                        ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if ((index == profileOptionClass.length - 1)) {
                                            rateUs_dialogue();
                                          } else {
                                            Get.to(profileOptionClass[index])?.then((value) {
                                              if (value != null) {
                                                Map m = value as Map;
                                                if (m.containsKey("changed")) {
                                                  int v = m['changed'] as int;

                                                  if (v == 1) {
                                                    print("Language changed");
                                                    checkLanguage();
                                                  }
                                                }
                                              }
                                            });
                                          }
                                          // (index ==
                                          //     profileOptionClass.length -
                                          //         1)
                                          //     ? rateUs_dialogue()
                                          //     : Get.to(
                                          //     profileOptionClass[index]);
                                        },
                                        child: Container(
                                          height: 60.h,
                                          width: double.infinity.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22.h),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                              ],
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 15.w),
                                                      Image(
                                                        image: AssetImage(profileoption[index].icon!),
                                                        color: const Color(0XFF503494),
                                                        height: 24.h,
                                                        width: 24.w,
                                                      ),
                                                      SizedBox(width: 15.w),
                                                      Text(
                                                        profileoption[index].title!,
                                                        style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 15.w),
                                                    child: Row(
                                                      children: [
                                                        Image(
                                                          image: const AssetImage("assets/right_arrow.png"),
                                                          height: 24.h,
                                                          width: 24.w,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 30.h),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 40.h, left: 20.h, right: 20.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      log_out_dialogue();
                                    },
                                    child: Container(
                                      height: 56.h,
                                      width: 374.w,

                                      //color: Color(0XFF503494),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0XFF503494),
                                          style: BorderStyle.solid,
                                          width: 1.0.w,
                                        ),
                                        borderRadius: BorderRadius.circular(20.h),
                                      ),
                                      child: Center(
                                        child: Text(mplanguage['logout'].toString(),
                                            style: TextStyle(
                                                color: const Color(0XFF503494), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //SizedBox(height: 30),
                        ],
                      ),
                    )
                  : Container(),
            ),
            if (myProfileController.isloader.value)
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

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();
    var a = await Utils.getOptions(lcode);
    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      profileoption = a;
      mplanguage = b;
    });
  }

  Future rateUs_dialogue() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: Image(
                image: const AssetImage('assets/rateUs.png'),
                height: 174.h,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: Text(
                mplanguage['giveyourop'].toString(),
                style: TextStyle(
                    fontSize: 18.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(mplanguage['makebetter'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w500, color: Color(0XFF000000))),
            ),
            SizedBox(height: 15.h),
            RatingBar(
              initialRating: myProfileController.rating.value,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              glow: false,
              ratingWidget: RatingWidget(
                  full: Image(
                    image: AssetImage("assets/fidbackfillicon.png"),
                  ),
                  half: Image(
                    image: AssetImage("assets/fidbackemptyicon.png"),
                  ),
                  empty: Image(
                    image: AssetImage("assets/fidbackemptyicon.png"),
                  )),
              itemPadding: EdgeInsets.symmetric(horizontal: 10),
              onRatingUpdate: (rating) {
                myProfileController.rating.value = rating;
                print(rating);
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.h),
                        color: const Color(0XFF503494),
                      ),
                      child: Center(
                          child: Text(
                        mplanguage['cancel'].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFFFFFFFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 13.sp),
                      )),
                    ),
                  )),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      // Get.off(HomeMainScreen());
                      myProfileController.ratingApi();
                      // controller.onChange(0);
                    },
                    child: Container(
                        height: 56.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFF503494),
                            style: BorderStyle.solid,
                            width: 1.0.w,
                          ),
                          borderRadius: BorderRadius.circular(22.h),
                        ),
                        child: Center(
                            child: Text(
                          mplanguage['submit'].toString(),
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF503494),
                              fontStyle: FontStyle.normal,
                              fontSize: 13.sp),
                        ))),
                  )),
                ],
              ),
            )
          ],
        ));
  }

  Future log_out_dialogue() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              Text(
                mplanguage['logoutalert'].toString(),
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h, bottom: 13.h),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        myProfileController.logout();
                      },
                      child: Container(
                        height: 56.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.h),
                          color: const Color(0XFF503494),
                        ),
                        child: Center(
                            child: Text(
                          mplanguage['yes'].toString(),
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFFFFFFF),
                              fontStyle: FontStyle.normal,
                              fontSize: 18.sp),
                        )),
                      ),
                    )),
                    SizedBox(width: 10.w),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          height: 56.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0XFF503494),
                              style: BorderStyle.solid,
                              width: 1.0.w,
                            ),
                            borderRadius: BorderRadius.circular(22.h),
                          ),
                          child: Center(
                              child: Text(
                            mplanguage['no'].toString(),
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF503494),
                                fontStyle: FontStyle.normal,
                                fontSize: 18.sp),
                          ))),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
