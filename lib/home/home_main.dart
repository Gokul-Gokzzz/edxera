import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/batchs/batches_main_screen.dart';
import 'package:edxera/homes/homes.dart';
import 'package:edxera/jobs/job_list_view.dart';
import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
import 'package:edxera/reels/controller/reel_controller.dart';
import 'package:edxera/reels/reels_home.dart';
import 'package:edxera/store/webview_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/home_screen.dart';
import '../My_cources/ongoing_completed_main_screen.dart';
import '../chate/chate_screen.dart';
import '../profile/my_profile.dart';
import '../repositories/api/api_constants.dart';
import '../utils/slider_page_data_model.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  // int currentvalue = 0;
  List userDetail = Utils.getUser();

  HomeMainController controller = Get.put(HomeMainController());
  ReelController reelController = Get.put(ReelController());
  final UserProfileController userProfileController = Get.put(UserProfileController());

  @override
  void initState() {
    reelController.getReels();
    controller.feedbackApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeMainController>(
      init: HomeMainController(),
      builder: (controller) => Scaffold(
        body: _body(),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22)),
              boxShadow: [
                BoxShadow(color: const Color(0XFF503494).withOpacity(0.12), spreadRadius: 0, blurRadius: 12),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
              ),
              child: BottomNavigationBar(
                  backgroundColor: const Color(0XFFFFFFFF),
                  currentIndex: controller.position.value,
                  onTap: (index) {
                    // setState(() {
                    //   currentvalue = index;
                    // });
                    controller.onChange(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Color(0XFF503494),
                  selectedIconTheme: IconThemeData(color: Color(0XFF503494)),
                  items: [
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(
                              image: AssetImage("assets/bottomhomeblue.png"),
                              height: 24,
                              width: 24,
                              color: Color(0XFF503494),
                            ),
                            SizedBox(height: 8.79),
                            Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
                          ],
                        ),
                        icon: const Image(
                          image: AssetImage("assets/bottomhomeblack.png"),
                          height: 24,
                          width: 24,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(
                              image: AssetImage("assets/homework.png"),
                              height: 24,
                              width: 24,
                              color: Color(0XFF503494),
                            ),
                            SizedBox(height: 8.79),
                            Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
                          ],
                        ),
                        icon: const Image(
                          image: AssetImage("assets/homework.png"),
                          height: 24,
                          width: 24,
                        ),
                        label: 'Courses'),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(image: AssetImage("assets/bottomhomeblue.png"), height: 24, width: 24, color: Color(0XFF503494)),
                            SizedBox(height: 8.79),
                            Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
                          ],
                        ),
                        icon: const Image(
                          image: AssetImage("assets/bottomhomeblack.png"),
                          height: 24,
                          width: 24,
                        ),
                        label: 'Batch'),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(image: AssetImage("assets/bottombookblue.png"), height: 24, width: 24, color: Color(0XFF503494)),
                            SizedBox(height: 8.79),
                            Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
                          ],
                        ),
                        icon: const Image(image: AssetImage("assets/bottombookblack.png"), height: 24, width: 24),
                        label: 'Jobs'),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(image: AssetImage("assets/bottommessegeblue.png"), height: 24, width: 24, color: Color(0XFF503494)),
                            SizedBox(height: 8.79),
                            Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
                          ],
                        ),
                        icon: const Image(image: AssetImage("assets/store.png"), height: 24, width: 24),
                        label: 'Store'),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 24.h,
                                width: 24.h,
                                imageUrl: "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
                                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                  child: Container(
                                    height: 24.h,
                                    width: 24.h,
                                    child: CircularProgressIndicator(value: downloadProgress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10.h),
                                  child: Container(
                                    height: 24.h,
                                    width: 24.h,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.79),
                            Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
                          ],
                        ),
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 24.h,
                            width: 24.h,
                            imageUrl: "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
                            progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                              child: Container(
                                height: 24.h,
                                width: 24.h,
                                child: CircularProgressIndicator(value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(10.h),
                              child: Container(
                                height: 24.h,
                                width: 24.h,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        label: 'Account'),
                  ]),
            )),
      ),
    );
  }

  _body() {
    switch (controller.position.value) {
      case 0:
        //return Center(child: Container(child: Text("1")));
        return ReelsHome();
      case 1:
        return HomeScreen();
      // return CourseListPage();
      case 2:
        //return Center(child: Container(child: Text("1")));
        return BatchesScreen();
      case 3:
        //return Center(child: Container(child: Text("2")));
        return JobListScreen();
      case 4:
        //return Center(child: Container(child: Text("3")));
        return const WebviewStore();
      case 5:
        return MyProfile();
      case 6:
        return MyProfile();

      default:
        return const Center(
          child: Text("inavalid"),
        );
    }
  }
}
