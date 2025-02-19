import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:edxera/cources/Models/cources_details_data_model.dart';
import 'package:edxera/cources/payment_screen1.dart';
import 'package:edxera/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/models/choose_plane.dart';
import 'package:edxera/cources/payment_screen.dart';
import 'package:edxera/utils/slider_page_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../My_cources/Models/course_data_entity.dart';

import '../utils/screen_size.dart';

class ChoosePlane extends StatefulWidget {
  final CourseDataEntity data;

  const ChoosePlane({Key? key, required this.data}) : super(key: key);

  @override
  State<ChoosePlane> createState() => _ChoosePlaneState();
}

class _ChoosePlaneState extends State<ChoosePlane> {
  ProfilePageController profilePageController =
      Get.put(ProfilePageController());

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  // List<ChoicePlane> plane = Utils.getChoosePlane();
  bool select = false;

//  ChoicePlane(
//           planeTime: '\$12/Month',
//           planfacelity1st: 'Lorem ipsum dolor sit amet',
//           planfacelity2nd: 'Lorem ipsum dolor sit amet',
//           planfacelity3rd: 'Lorem ipsum dolor sit amet',
//           image: 'assets/right.png',
//           cho: false,
//           id: 1),

  void _launchWhatsApp(String phoneNumber) async {
    try {
      const message = 'Hello, I need some information about the course.';
      final url =
          'https://wa.me/+91$phoneNumber?text=${Uri.encodeFull(message)}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Failed to open whatsapp',
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Failed to open whatsapp',
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    try {
      final url = 'tel:+91${phoneNumber}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Failed to make call ',
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Failed to make call ',
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured  screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        body: GetBuilder<ProfilePageController>(
            init: ProfilePageController(),
            builder: (controller) => SingleChildScrollView(
                  child: Screenshot(
                    controller: screenshotController,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Image(
                                      image:
                                          AssetImage("assets/back_arrow.png"),
                                      height: 24.h,
                                      width: 24.w,
                                    )),
                                SizedBox(width: 16.w),
                                Text(
                                  "Course Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Gilroy',
                                      fontSize: 24.sp),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    screenshotController
                                        .capture(
                                            delay: Duration(milliseconds: 10))
                                        .then((capturedImage) async {
                                      final directory =
                                          await getApplicationDocumentsDirectory();
                                      final imagePath = await File(
                                              '${directory.path}/screenshot${DateTime.now().millisecondsSinceEpoch}.png')
                                          .create();
                                      await imagePath
                                          .writeAsBytes(capturedImage!);

                                      Share.shareXFiles(
                                          [XFile(imagePath.path)]);
                                    }).catchError((onError) {
                                      print(onError);
                                    });
                                  },
                                  child: Icon(Icons.share),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.h),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15.w,
                                    right: 15.w,
                                    top: 10.h,
                                    bottom: 15.h),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Helpline phone numbers',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '8129935578',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blue),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            _launchWhatsApp('8129935578');
                                          },
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                  Assets.assetsWhatsapp)),
                                        ),
                                        SizedBox(width: 5.h),
                                        InkWell(
                                          onTap: () {
                                            _makePhoneCall('8129935578');
                                          },
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                  Assets.assetsCallicon)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '8075707353',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blue),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            _launchWhatsApp('8075707353');
                                          },
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                  Assets.assetsWhatsapp)),
                                        ),
                                        SizedBox(width: 5.h),
                                        InkWell(
                                          onTap: () {
                                            _makePhoneCall('8075707353');
                                          },
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                  Assets.assetsCallicon)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.h),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0XFF503494)
                                              .withOpacity(0.14),
                                          offset: const Offset(-4, 5),
                                          blurRadius: 16.h),
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 10.h,
                                      bottom: 15.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.data.data?.course?.title ?? '',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        'Price ₹ ${widget.data.data?.course?.price ?? ''}',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),

                            Image.asset('assets/payment.jpeg'),
                            // Text(
                            //     "🟥 *Current Account* * \n PUNJAB NATIONAL BANK. (PNB* ) ❇ \n *Account Name* : *OXFORD COMMUNITY COLLEGE. (Affiliated CENTRE OF KGTE. WANDOOR KALIKAVU)* \n\n  ✅ *Account number : \n\n A/c  No. 4363002100007444 \n\n ☑  IFSC. PUNB0436300 \n\n Branch -WANDOOR \n\n Google pay \n OXFORD COMMUNITY COLLEGE :- 6235780340   \n\nPhonePe* \n OXFORD COMMUNITY COLLEGE:-  6235780340* \n\n--------------------------\n\n--------------------------\n\n🩸വിദ്യാർത്ഥികളുടെ ശ്രദ്ധക്ക്🩸 \n\nബാങ്ക് ഡീറ്റെയിൽസ് \n\n\n\n Helpline 8848934728" ,style: TextStyle(fontSize: 18),),
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.to(const PaymenConfirm1());
                            //   },
                            //   child: Container(
                            //     height: 56.h,
                            //     width: 374.w,
                            //     //color: Color(0XFF503494),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(20.h),
                            //       color: const Color(0XFF503494),
                            //     ),
                            //     child: Center(
                            //       child: Text("Payment",
                            //           style: TextStyle(
                            //               color: const Color(0XFFFFFFFF),
                            //               fontSize: 18.sp,
                            //               fontWeight: FontWeight.w700,
                            //               fontFamily: 'Gilroy')),
                            //     ),
                            //   ),
                            // )
                            // Expanded(
                            //   child: ListView.builder(
                            //       itemCount: plane.length,
                            //       itemBuilder: (context, index) {
                            //         return Padding(
                            //           padding: EdgeInsets.all(8.0.h),
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12.h),
                            //                 boxShadow: [
                            //                   BoxShadow(
                            //                       color: const Color(0XFF503494)
                            //                           .withOpacity(0.14),
                            //                       offset: const Offset(-4, 5),
                            //                       blurRadius: 16.h),
                            //                 ],
                            //                 color: Colors.white),
                            //             child: Padding(
                            //               padding: EdgeInsets.only(
                            //                   left: 15.w,
                            //                   right: 15.w,
                            //                   top: 10.h,
                            //                   bottom: 15.h),
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment
                            //                             .spaceBetween,
                            //                     children: [
                            //                       Text(
                            //                         plane[index].planeTime!,
                            //                         style: TextStyle(
                            //                             fontSize: 20.sp,
                            //                             fontFamily: 'Gilroy',
                            //                             fontWeight:
                            //                                 FontWeight.w700),
                            //                       ),
                            //                       Radio(
                            //                           activeColor:
                            //                               Color(0XFF503494),
                            //                           value: profilePageController
                            //                               .choice[index],
                            //                           groupValue:
                            //                               profilePageController
                            //                                   .select,
                            //                           onChanged: (value) {
                            //                             profilePageController
                            //                                 .onClickRadioButton(
                            //                                     value);
                            //                             select = true;
                            //                           })
                            //                     ],
                            //                   ),
                            //                   Row(
                            //                     children: [
                            //                       Image(
                            //                         image: AssetImage(
                            //                             plane[index].image!),
                            //                         height: 16.h,
                            //                         width: 16.w,
                            //                       ),
                            //                       SizedBox(width: 10.w),
                            //                       Text(
                            //                         plane[index].planfacelity1st!,
                            //                         style: TextStyle(
                            //                             fontFamily: 'Gilroy',
                            //                             fontWeight:
                            //                                 FontWeight.normal,
                            //                             color: Color(0XFF000000),
                            //                             fontSize: 15.sp),
                            //                       )
                            //                     ],
                            //                   ),
                            //                   SizedBox(height: 10.h),
                            //                   Row(
                            //                     children: [
                            //                       Image(
                            //                         image: AssetImage(
                            //                             plane[index].image!),
                            //                         height: 16.h,
                            //                         width: 16.w,
                            //                       ),
                            //                       SizedBox(width: 10.w),
                            //                       Text(
                            //                         plane[index].planfacelity2nd!,
                            //                         style: TextStyle(
                            //                             fontFamily: 'Gilroy',
                            //                             fontWeight:
                            //                                 FontWeight.normal,
                            //                             color: Color(0XFF000000),
                            //                             fontSize: 15.sp),
                            //                       )
                            //                     ],
                            //                   ),
                            //                   SizedBox(height: 10.h),
                            //                   Row(
                            //                     children: [
                            //                       Image(
                            //                         image: AssetImage(
                            //                             plane[index].image!),
                            //                         height: 16.h,
                            //                         width: 16.w,
                            //                       ),
                            //                       SizedBox(width: 10.w),
                            //                       Text(
                            //                         plane[index].planfacelity3rd!,
                            //                         style: TextStyle(
                            //                             fontFamily: 'Gilroy',
                            //                             fontWeight:
                            //                                 FontWeight.normal,
                            //                             color: Color(0XFF000000),
                            //                             fontSize: 15.sp),
                            //                       )
                            //                     ],
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       }),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
