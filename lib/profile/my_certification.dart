import 'dart:collection';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/controller.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../repositories/api/api_constants.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class MyCertification extends StatefulWidget {
  const MyCertification({Key? key}) : super(key: key);

  @override
  State<MyCertification> createState() => _MyCertificationState();
}

class _MyCertificationState extends State<MyCertification> {
  MyCertificationScreenConyroller myCertificationScreenConyroller = Get.put(MyCertificationScreenConyroller());

  Map<String, dynamic> mplanguage = new HashMap();

  @override
  void initState() {
    myCertificationScreenConyroller.getCretificate();
    super.initState();
    print(getAndroidVersion());
    checkLanguage();
  }

  String convertCurrentDateTimeToString() {
    String formattedDateTime = DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<String?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    }
    throw UnsupportedError("Platform is not Android");
  }

  Future<void> downloadFile(String path) async {
    myCertificationScreenConyroller.isloader(true);
    Dio dio = Dio();

    if (Platform.isAndroid && await getAndroidVersion() == '13') {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(path, dirloc + convertCurrentDateTimeToString() + ".pdf", onReceiveProgress: (receivedBytes, totalBytes) {
          print(dirloc + convertCurrentDateTimeToString() + ".pdf");
          print('here 1');
          myCertificationScreenConyroller.isloader(false);
          // Get.snackbar("", 'Download Complete');
          print('here 2');
        });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }
      print(path);
      print('here give alert-->completed');
      return;
    }
    final status = await Permission.storage.request();

    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(path, dirloc + convertCurrentDateTimeToString() + ".pdf", onReceiveProgress: (receivedBytes, totalBytes) {
          print(dirloc + convertCurrentDateTimeToString() + ".pdf");
          print('here 1');
          myCertificationScreenConyroller.isloader(false);
          // Get.snackbar("", 'Download Complete');
          print('here 2');
        });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }
      print(path);
      print('here give alert-->completed');
    } else {}
    myCertificationScreenConyroller.isloader(false);
  }

  int selectdindex = 0;

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
      appBar: AppBar(
        title: Text(
          mplanguage['certification'].toString(),
          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Gilroy', fontSize: 20),
        ),
        centerTitle: false,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    myCertificationScreenConyroller.getCourseCertificateDataModel.data != null
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 1.8,
                            child: (myCertificationScreenConyroller.getCourseCertificateDataModel != null)
                                ? PageView.builder(
                                    onPageChanged: (value) {
                                      selectdindex = value;
                                      setState(() {});
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: myCertificationScreenConyroller.getCourseCertificateDataModel.data?.courseCertificate?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          // image: NetworkImage(
                                          //   "${ApiConstants.publicBaseUrl}/${myCertificationScreenConyroller.getCourseCertificateDataModel.data?.courseCertificate?[index].certificateFile ?? ''}",
                                          // ),

                                          child: PDF().cachedFromUrl(
                                        "${ApiConstants.publicBaseUrl}/${myCertificationScreenConyroller.getCourseCertificateDataModel.data?.courseCertificate?[index].certificateFile ?? ''}",
                                        errorWidget: (error) => Center(child: Text(error.toString())),
                                      ));
                                    },
                                  )
                                : Text(
                                    mplanguage['nodata'].toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 1.8,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Text(mplanguage['nodata'].toString()),
                                )
                              ],
                            )),
                    myCertificationScreenConyroller.getCourseCertificateDataModel.data != null ? download_button() : Container(),
                  ],
                ),
              ),
            ),
            if (myCertificationScreenConyroller.isloader.value)
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

  Widget download_button() {
    return GestureDetector(
      onTap: () {
        downloadFile(
            "${ApiConstants.publicBaseUrl}/${myCertificationScreenConyroller.getCourseCertificateDataModel.data?.courseCertificate?[selectdindex].certificateFile ?? ''}");
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
        child: Container(
          height: 56.h,
          width: 374.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: const Color(0XFF503494),
          ),
          child: Center(
            child: Text(mplanguage['downloadcertificate'].toString(),
                style: TextStyle(color: const Color(0XFFFFFFFF), fontSize: 13.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
          ),
        ),
      ),
    );
  }
}
