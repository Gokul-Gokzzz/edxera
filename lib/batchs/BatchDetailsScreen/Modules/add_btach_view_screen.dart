import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/controllers/batch_main_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';

class AddBatchViewScreen extends StatefulWidget {
  const AddBatchViewScreen({super.key});

  @override
  State<AddBatchViewScreen> createState() => _AddBatchViewScreenState();
}

class _AddBatchViewScreenState extends State<AddBatchViewScreen> {
  BatchDeatilsControleller courceDetailController = Get.put(BatchDeatilsControleller());

  TextEditingController batchCodeController = TextEditingController();

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
    initializeScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: Text(
          mplanguage['enterbatchcode'].toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    mplanguage['askyourteacher'].toString(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                        controller: batchCodeController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(10)),
                          hintText: mplanguage['getcodefromteacher'].toString(),
                          hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
                        )),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (batchCodeController.text != '') {
                        courceDetailController.joinBatchClass(batchCodeController.text);
                      } else {
                        Get.showSnackbar(
                          GetSnackBar(
                            backgroundColor: Colors.red,
                            message: mplanguage['enterbatchcode'].toString(),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.h, top: 15.h),
                      child: Container(
                        height: 56.h,
                        width: 374.w,
                        //color: Color(0XFF503494),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                          color: const Color(0XFF503494),
                        ),
                        child: Center(
                          child: Text(mplanguage['join'].toString(),
                              style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
                        ),
                      ),
                    ),
                  )
                ],
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
}
