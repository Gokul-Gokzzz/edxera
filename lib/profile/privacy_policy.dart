import 'dart:collection';

import 'package:edxera/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';
import 'Models/privacypolicy_entity.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  //PrivacyPolicyController
  PrivacyPolicyController privacyPolicyController = Get.put(PrivacyPolicyController());
  late WebViewController webController;
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkLanguage();
      webController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) {
              if (progress > 99) {
                setState(() {
                  isLoading = false;
                });
              }
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        ..loadRequest(Uri.parse(pp?.data?.privacyPolicyPage.content ?? ''));
    });

    super.initState();
  }

  Map<String, dynamic> mplanguage = new HashMap();

  String htmlcontent = "";

  PrivacypolicyEntity? pp;

  Future<void> checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
    var c = await privacyPolicyController.contactListDataApi();
    setState(() {
      pp = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mplanguage['privacy_policy'].toString(),
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
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Stack(
          children: [
            Align(
              alignment: FractionalOffset.topCenter,
              child: (pp?.data?.privacyPolicyPage.content != null)
                  ? SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: WebViewWidget(
                        controller: webController,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(mplanguage['nodata'].toString()),
                          )
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  question(String s) {
    return Text(
      s,
      style: TextStyle(fontSize: 18.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700, color: const Color(0XFF000000)),
    );
  }

  answer(String s) {
    return Text(
      s,
      style: TextStyle(fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, color: Color(0XFF292929)),
    );
  }
}
