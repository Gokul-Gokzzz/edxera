import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class CardBottomSheet extends StatefulWidget {
  const CardBottomSheet({Key? key}) : super(key: key);

  @override
  State<CardBottomSheet> createState() => _CardBottomSheetState();
}

class _CardBottomSheetState extends State<CardBottomSheet> {
  bool ischeaked = false;

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

    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10.h),
        Center(
            child: Container(
                height: 4.h, width: 48.w, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.h), color: const Color(0XFF12121D)))),
        SizedBox(height: 9.h),
        Text(
          mplanguage['addnewcard'].toString(),
          style: TextStyle(fontSize: 18.sp, fontFamily: 'Gilroy', color: Color(0XFF000000)),
        ),
        SizedBox(height: 20.h),
        card_name_field(mplanguage['nameoncard'].toString(), 'assets/profileicon1st.png'),
        SizedBox(height: 20.h),
        card_name_field(mplanguage['cardnumber'].toString(), 'assets/numberbox.png'),
        SizedBox(height: 20.h),
        Row(
          children: [date_and_cvv_field('MM/YY'), SizedBox(width: 20.w), date_and_cvv_field(mplanguage['cvv'].toString())],
        ),
        SizedBox(height: 20.5.h),
        save_card_cheakbox(),
        SizedBox(height: 21.h),
        add_button(),
        SizedBox(
          height: 40.h,
        )
      ]),
    );
  }

  card_name_field(String s, String t) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: [
            BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
          ],
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: s,
              contentPadding: EdgeInsets.only(top: 19.h, bottom: 14.h),
              prefixIcon: Padding(
                padding: EdgeInsets.all(7.0.h),
                child: Container(
                  // color: Colors.red,
                  height: 24.h,
                  width: 24.h,
                  child: Image(
                    image: AssetImage(t),
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
              ),
              border: InputBorder.none),
          style: TextStyle(fontSize: 15.sp, color: Color(0XFF6E758A), fontFamily: 'Gilroy', fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  date_and_cvv_field(String s) {
    return Expanded(
      child: Container(
        height: 60.h,
        width: double.infinity.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.h),
            boxShadow: [
              BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
            ],
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(8.0.h),
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: s,
              contentPadding: EdgeInsets.only(left: 18.w, top: 18.h, bottom: 14.h),
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 15.sp, color: Color(0XFF6E758A), fontFamily: 'Gilroy', fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget save_card_cheakbox() {
    return Row(
      children: [
        Checkbox(
          value: ischeaked,
          activeColor: const Color(0XFF503494),
          side: const BorderSide(color: Color(0XFFDEDEDE)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.h)),
          onChanged: (value) {
            setState(() {
              ischeaked = value!;
            });
          },
        ),
        SizedBox(width: 10.w),
        Text(
          mplanguage['savecard'].toString(),
          style: TextStyle(fontFamily: 'Gilroy', color: Color(0XFF000000), fontSize: 15.sp),
        )
      ],
    );
  }

  Widget add_button() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 56.h,
        width: 374.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          color: ischeaked ? const Color(0XFF503494) : Colors.grey,
        ),
        child: Center(
          child: Text(mplanguage['add'].toString(),
              style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
        ),
      ),
    );
  }
}
