import 'dart:collection';

import 'package:edxera/profile/Controllers/MyPaymentDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/shared_pref.dart';

class MyPaymentDetails extends StatefulWidget {
  MyPaymentDetails();

  @override
  _MyPaymentDetailsState createState() => _MyPaymentDetailsState();
}

class _MyPaymentDetailsState extends State<MyPaymentDetails> {
  MyPaymentDetailsController paymentDetailsController = Get.put(MyPaymentDetailsController());
  @override
  void initState() {
    // TODO: implement initState
    paymentDetailsController.getAnnouncementData();
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            mplanguage['paymentdetails'].toString(),
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
                size: 17,
              )),
        ),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Stack(
              children: [
                (paymentDetailsController.batchAnnouncementDataModel?.data?.fee!.length == 0)
                    ? Align(
                        alignment: FractionalOffset.center,
                        child: Padding(
                          padding: EdgeInsets.all(13),
                          child: Text(
                            mplanguage['nodata'].toString(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ))
                    : Align(
                        alignment: FractionalOffset.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height / 1.5,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            width: double.infinity,
                                            height: 120,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: FractionalOffset.center,
                                                  child: Image.asset(
                                                    "assets/shop.png",
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['name'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.studentDetails.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['email'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.email.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['coursename'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].courseName.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['paidamount'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].paidAmount.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['balanceamount'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].balanceAmount.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['paymentstatus'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              (paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].paidStatus == 0)
                                                  ? Expanded(
                                                      child: Text(
                                                        "Failed",
                                                        style: TextStyle(fontSize: 14),
                                                      ),
                                                      flex: 1,
                                                    )
                                                  : Expanded(
                                                      child: Text(
                                                        "Success",
                                                        style: TextStyle(fontSize: 14),
                                                      ),
                                                      flex: 1,
                                                    ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['paymenttype'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].paymentType.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['paymentdate'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].paidDate.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  mplanguage['paymenttime'].toString() + " : ",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  paymentDetailsController.batchAnnouncementDataModel!.data!.fee[0].paidTime.toString(),
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          ))
                                    ],
                                  )),
                            ),
                            elevation: 6,
                          ),
                        ))
              ],
            ),
          ),
        ));
  }
}
