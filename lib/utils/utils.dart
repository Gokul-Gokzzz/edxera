import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static showToast(BuildContext context, String message) {
    return Fluttertoast.showToast(
      msg: message,
    );
  }

  // static String popupdate() {
  //   var login = Preference.shared.getString(Preference.dateOfPopup);
  //   return (login!);
  // }

  static bool isPurchased() {
    //return false;
    return true;
  }

  static showBottomSheetDialog({required Widget child}) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0XFF503494),
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  static dismissKeyboard() {
    return FocusScope.of(Get.context!).unfocus();
  }

  String getLocaalTime(String gmt) {
    String time = DateFormat('MMMM yyyy').format(DateFormat('dd-MM-yyyy').parse(gmt));
    return time;
  }
}
