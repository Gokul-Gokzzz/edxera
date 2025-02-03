import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/controllers/batch_main_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  BatchDeatilsControleller courceDetailController = Get.put(BatchDeatilsControleller());

  @override
  void initState() {
    courceDetailController.batchDataGets(widget.id);
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
      backgroundColor: Colors.transparent,
      body: Obx(
        () => Stack(
          children: [
            courceDetailController.batcheDetailsDataModel.data != null
                ? ListView(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                mplanguage['courses'].toString(),
                                style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  (courceDetailController.batcheDetailsDataModel.data?.batches?.courseTitle ?? '').toUpperCase(),
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              if (courceDetailController.batcheDetailsDataModel.data?.requestAcceptedStatus == 0)
                                InkWell(
                                  onTap: () {
                                    if (courceDetailController.batcheDetailsDataModel.data?.joinRequestStatus == 1) {
                                      Get.showSnackbar(
                                        GetSnackBar(
                                          backgroundColor: Colors.red,
                                          message: 'You have alredy send request to join class',
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    } else {
                                      courceDetailController.joinClass(widget.id);
                                    }
                                  },
                                  child: Container(
                                    height: 40.w,
                                    width: 130.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: courceDetailController.batcheDetailsDataModel.data?.joinRequestStatus == 1
                                          ? Color(0XFF503494).withOpacity(0.2)
                                          : Color(0XFF503494),
                                      borderRadius: BorderRadius.circular(5.h),
                                    ),
                                    child: Text(
                                      mplanguage['joinclass'].toString(),
                                      style: TextStyle(
                                          color: courceDetailController.batcheDetailsDataModel.data?.joinRequestStatus == 1
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 4,
                            decoration: BoxDecoration(
                              color: Color(0XFF503494).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                mplanguage['batchcode'].toString(),
                                style: TextStyle(fontSize: 12.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    (courceDetailController.batcheDetailsDataModel.data?.batches?.batchCode ?? '').toUpperCase(),
                                    style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(new ClipboardData(text: 'fd'));
                                      Fluttertoast.showToast(
                                          msg: "Copied",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.SNACKBAR,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0.sp);
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    Stack(
                                      children: [
                                        Container(
                                          height: 300.h,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(10.h),
                                                child: Center(
                                                  child: Text(
                                                    mplanguage['sharethismessage'].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                color: Colors.grey.withOpacity(0.2),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.h, top: 10.h),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        mplanguage['class'].toString() + ' : ',
                                                        style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        (courceDetailController.batcheDetailsDataModel.data?.batches?.courseTitle ?? ''),
                                                        maxLines: 2,
                                                        style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.h),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        mplanguage['subject'].toString() + ' : ',
                                                        style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        (courceDetailController.batcheDetailsDataModel.data?.batches?.name ?? ''),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
                                                      ),
                                                      flex: 1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.h),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        mplanguage['batchcode'].toString() + ' : ',
                                                        style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        (courceDetailController.batcheDetailsDataModel.data?.batches?.batchCode ?? ''),
                                                        style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  String sharetxt = "";

                                                  String batchcode = courceDetailController.batcheDetailsDataModel.data?.batches?.batchCode ?? '';
                                                  String coursename = courceDetailController.batcheDetailsDataModel.data?.batches?.courseTitle ?? '';
                                                  String batchname = courceDetailController.batcheDetailsDataModel.data?.batches?.name ?? '';

                                                  if (batchcode.isNotEmpty) {
                                                    sharetxt = sharetxt + "Batch Code : " + batchcode + "\n";
                                                  }

                                                  if (coursename.isNotEmpty) {
                                                    sharetxt = sharetxt + "Course name : " + coursename + "\n";
                                                  }

                                                  if (batchname.isNotEmpty) {
                                                    sharetxt = sharetxt + "Batch name : " + batchname + "\n";
                                                  }

                                                  Get.back();
                                                  await Share.share(
                                                    sharetxt +
                                                        '\nJoin OWEOC, the ultimate online e-learning portal, and enhance your skills with top-notch courses today! \n' +
                                                        '\n Click here to download the app : ' +
                                                        "https://play.google.com/store/apps/details?id=com.oxford.wandoor",
                                                    subject: 'Share App',
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(20.h),
                                                  height: 50.h,
                                                  //color: Color(0XFF503494),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.h),
                                                    color: const Color(0XFF503494),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.share,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(mplanguage['share'].toString(),
                                                            style: TextStyle(
                                                                color: Color(0XFFFFFFFF),
                                                                fontSize: 18.sp,
                                                                fontWeight: FontWeight.w700,
                                                                fontFamily: 'Gilroy')),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     Get.back();
                                              //     whatsapp();
                                              //   },
                                              //   child: Container(
                                              //     margin: EdgeInsets.only(
                                              //         left: 20.h, right: 20.h),
                                              //     height: 50.h,
                                              //     //color: Color(0XFF503494),
                                              //     decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               20.h),
                                              //       color:
                                              //           const Color(0XFF503494),
                                              //     ),
                                              //     child: Center(
                                              //       child: Row(
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment
                                              //                 .center,
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment
                                              //                 .center,
                                              //         children: [
                                              //           Image(
                                              //             image: AssetImage(
                                              //                 'assets/whatsapp_icon.png'),
                                              //             height: 24.h,
                                              //             width: 24.w,
                                              //             color: Colors.white,
                                              //           ),
                                              //           SizedBox(
                                              //             width: 5.w,
                                              //           ),
                                              //           Text(   mplanguage['whatsapp'].toString(),
                                              //               style: TextStyle(
                                              //                   color: Color(
                                              //                       0XFFFFFFFF),
                                              //                   fontSize: 18.sp,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .w700,
                                              //                   fontFamily:
                                              //                       'Gilroy')),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          top: 10,
                                          child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40.w,
                                  width: 130.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.h),
                                    color: const Color(0XFF503494),
                                  ),
                                  child: Text(
                                    mplanguage['invitefriends'].toString(),
                                    style: TextStyle(color: Colors.white, fontSize: 11.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color(0XFF503494).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.h),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 15.w,
                        ),
                        child: Text(
                          mplanguage['time'].toString(),
                          style: TextStyle(fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: courceDetailController.batcheDetailsDataModel.data?.timings?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                boxShadow: [
                                  BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                ],
                                color: Colors.white),
                            child: Container(
                              margin: EdgeInsets.all(15.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    courceDetailController.batcheDetailsDataModel.data?.timings?[index].day ?? '',
                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        mplanguage['starts'].toString(),
                                        style: TextStyle(fontSize: 10.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        courceDetailController.batcheDetailsDataModel.data?.timings?[index].fromTime ?? '',
                                        style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        mplanguage['ends'].toString(),
                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        courceDetailController.batcheDetailsDataModel.data?.timings?[index].toTime ?? '',
                                        style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                : Container(
                    child: Text(
                      courceDetailController.batcheDetailsDataModel.message ?? '',
                      style: TextStyle(fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                    ),
                  ),
            if (courceDetailController.isloader.value)
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

  whatsapp() async {
    var contact = "+880123232333";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Fluttertoast.showToast(msg: 'WhatsApp is not installed');
    }
  }
}
