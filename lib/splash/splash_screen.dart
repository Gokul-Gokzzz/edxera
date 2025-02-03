import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/home/home_main.dart';
import 'package:edxera/login/login_empty_state.dart';
import 'package:edxera/onboarding/omboarding.dart';
import 'package:edxera/utils/shared_pref.dart';

import '../repositories/post_repository.dart';
import '../utils/screen_size.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    getIntro();
  }

  getIntro() async {
    bool isIntro = await PrefData.getIntro();
    bool isLogin = await PrefData.getLogin();
    int userId = await PrefData.getUserId();
    PostRepository postRepository = PostRepository();
    if (isIntro == false) {
      Timer(const Duration(seconds: 5), () => Get.offAll(() => const SlidePage()));
    } else if (isLogin == false) {
      Get.to(() => const EmptyState());
    } else if (userId == 0) {
      Timer(const Duration(seconds: 5), () => Get.offAll(() => const EmptyState()));
    } else {
      final isUserExit = await postRepository.checkUserExist();
      if (isUserExit) {
        Timer(const Duration(seconds: 3), () => Get.offAll(const HomeMainScreen()));
      } else {
        Timer(const Duration(seconds: 5), () => Get.offAll(() => const EmptyState()));
      }
    }
  }

  // PrefData.setVarification(true);

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
                  // height: 95.h,
                  width: 0.5.sw,
                  child: Image(
                    image: const AssetImage("assets/app_logo.jpeg"),
                    fit: BoxFit.cover,
                  ))),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
