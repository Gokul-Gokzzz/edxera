import 'dart:io';

import 'package:edxera/controller/controller.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  HelpCenterController helpCenterController = Get.put(HelpCenterController());

  @override
  void initState() {
    helpCenterController.faqsListDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Obx(
      () => Stack(
        children: [
          helpCenterController.faaqsListDataModel.data != null
              ? ListView.builder(
                  itemCount: helpCenterController.faaqsListDataModel.data?.faqs?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Color(0XFF503494).withOpacity(0.14), offset: Offset(-4, 5), blurRadius: 16.h)]),
                        child: ExpansionTileCard(
                          borderRadius: BorderRadius.circular(22.h),
                          trailing: Image.asset("assets/down.png", height: 24.h, width: 24.w),
                          animateTrailing: true,
                          title: Text(
                            helpCenterController.faaqsListDataModel.data?.faqs?[index].question ?? '',
                            style: const TextStyle(color: Color(0XFF000000), fontFamily: 'Gilroy', fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: Text(
                                helpCenterController.faaqsListDataModel.data?.faqs?[index].answer ?? '',
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 14, fontFamily: 'Gilroy', fontStyle: FontStyle.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(),
          if (helpCenterController.isloader.value)
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
    );
  }
}
