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

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    getIntro();

    // Fade-in animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  getIntro() async {
    try {
      bool isIntro = await PrefData.getIntro();
      bool isLogin = await PrefData.getLogin();
      int userId = await PrefData.getUserId();
      PostRepository postRepository = PostRepository();
      if (isIntro == false) {
        Get.offAll(() => const SlidePage());
      } else if (isLogin == false) {
        Get.to(() => const EmptyState());
      } else if (userId == 0) {
        Get.offAll(() => const EmptyState());
      } else {
        final isUserExit = await postRepository.checkUserExist();
        if (isUserExit) {
          Get.offAll(const HomeMainScreen());
        } else {
          Get.offAll(() => const EmptyState());
        }
      }
    } catch (e) {
      Get.offAll(() => const EmptyState());
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                // App Logo
                Container(
                  width: 0.5.sw,
                  child: Image.asset(
                    "assets/app_logo.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30),

                // Divider Line
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1.5,
                  ),
                ),
                SizedBox(height: 20),

                // Fade-in "Powered by" section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'Powered by',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 10),

                      // Cosysta Logo with Shadow Effect
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Image.asset(
                          "assets/poweredby.jpeg",
                          height: 80.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
