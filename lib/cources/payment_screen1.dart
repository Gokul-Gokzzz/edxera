import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/home_main.dart';
import 'package:edxera/models/payment_selection.dart';
import 'package:edxera/utils/slider_page_data_model.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../profile/add_card_bottomsheet.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class PaymenConfirm1 extends StatefulWidget {
  const PaymenConfirm1({Key? key}) : super(key: key);

  @override
  State<PaymenConfirm1> createState() => _PaymenConfirm1State();
}

class _PaymenConfirm1State extends State<PaymenConfirm1> {
  PaymentSelectionController paymentSelectionController = Get.put(PaymentSelectionController());

  bool select = false;
  List<Payment> selectPaymentType = [];

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
      selectPaymentType = Utils.getPayment(mplanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        body: GetBuilder<PaymentSelectionController>(
            init: PaymentSelectionController(),
            builder: (controller) => SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image(
                                  image: const AssetImage("assets/back_arrow.png"),
                                  height: 24.h,
                                  width: 24.w,
                                )),
                            SizedBox(width: 15.w),
                            Text(
                              "Payment",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp, fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: 60.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.h),
                              boxShadow: [
                                BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                              ],
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, fontFamily: 'Gilroy'),
                                ),
                                Text(
                                  "\$99",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, fontFamily: 'Gilroy', color: Color(0XFF503494)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Select Payment",
                          style: TextStyle(fontSize: 20.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: ListView(children: [
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: selectPaymentType.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: Container(
                                      height: 64.h,
                                      width: double.infinity.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.h),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                          ],
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(selectPaymentType[index].image!),
                                                  height: 24.h,
                                                  width: 24.w,
                                                ),
                                                SizedBox(width: 30.w),
                                                Text(
                                                  selectPaymentType[index].title!,
                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                            Radio(
                                                activeColor: const Color(0XFF503494),
                                                value: paymentSelectionController.choice[index],
                                                groupValue: paymentSelectionController.select,
                                                onChanged: (value) {
                                                  paymentSelectionController.onClickPaymentRadioButton(value);
                                                  select = true;
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            add_new_button(),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: confirm_button(select),
                        )
                      ],
                    ),
                  ),
                )));
  }

  Widget add_new_button() {
    return Center(
        child: GestureDetector(
      onTap: () {
        Get.bottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(22.h), topRight: Radius.circular(22.h))),
            CardBottomSheet());
      },
      child: Text(
        "Add New +",
        style: TextStyle(fontSize: 18.sp, color: Color(0XFF503494), fontFamily: 'Gilroy'),
      ),
    ));
  }

  confirm_button(bool select) {
    return select
        ? GestureDetector(
            onTap: () {
              Get.defaultDialog(
                  title: '',
                  barrierDismissible: false,
                  content: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/successpayment.png',
                        ),
                        height: 120.h,
                        width: 120.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        mplanguage['paymentsuccess'].toString(),
                        style: TextStyle(fontSize: 28.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                        style: TextStyle(color: const Color(0XFF292929), fontFamily: 'Gilroy', fontSize: 15.sp, fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 20.h, right: 10.w, left: 10.w),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(HomeMainScreen());
                          },
                          child: Container(
                            height: 56.h,
                            width: 374.w,
                            //color: Color(0XFF503494),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.h),
                              color: const Color(0XFF503494),
                            ),
                            child: Center(
                              child: Text("Back To Home",
                                  style:
                                      TextStyle(color: const Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            child: Container(
              height: 56,
              width: 374,
              //color: Color(0XFF503494),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0XFF503494),
              ),
              child: const Center(
                child: Text("Confirm", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
              ),
            ),
          )
        : const SizedBox();
  }
}
