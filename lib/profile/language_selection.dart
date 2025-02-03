import 'package:edxera/languagecontrols/LanguageCheck.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:edxera/utils/slider_page_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelection extends StatefulWidget {
  LanguageSelection();

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String languagecode = "", languagetitle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            // leading: GestureDetector(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: Image(
            //     image: AssetImage("assets/back_arrow.png"),
            //     height: 22.h,
            //     width: 22.w,
            //   ),
            // ),
            centerTitle: false,
            title: Text(
              languagetitle,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
            ),
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pop({"changed": 1});
              },
            )),
        body: Stack(
          children: [
            Align(
              alignment: FractionalOffset.topCenter,
              child: ListView.builder(
                  itemCount: Utils.getLanguages().length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                          child: ListTile(
                              leading: (languagecode.compareTo(Utils.getLanguageCodes()[index]) != 0)
                                  ? Icon(
                                      Icons.radio_button_off,
                                      color: Color(0xff020A35),
                                      size: 20,
                                    )
                                  : Icon(
                                      Icons.radio_button_checked,
                                      color: Color(0xff020A35),
                                      size: 20,
                                    ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black12,
                                size: 20,
                              ),
                              title: Text(
                                Utils.getLanguages()[index],
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ))),
                      onTap: () async {
                        PrefData.setLanguage(Utils.getLanguageCodes()[index]);

                        Navigator.of(context).pop({"changed": 1});
                      },
                    );
                  }),
            )
          ],
        ));
  }

  getLanguage() async {
    String lcode = await PrefData.getLanguage();

    Map mp = await LanguageCheck.checkLanguage(lcode);

    setState(() {
      languagecode = lcode;
      languagetitle = mp['chnage_language'];
    });
  }
}
