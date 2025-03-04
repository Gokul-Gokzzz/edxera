// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:edxera/batchs/batches_main_screen.dart';
// import 'package:edxera/homes/homes.dart';
// import 'package:edxera/jobs/job_list_view.dart';
// import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
// import 'package:edxera/reels/controller/reel_controller.dart';
// import 'package:edxera/reels/reels_home.dart';
// import 'package:edxera/store/webview_store.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:edxera/controller/controller.dart';
// import 'package:edxera/home/home_screen.dart';
// import '../My_cources/ongoing_completed_main_screen.dart';
// import '../chate/chate_screen.dart';
// import '../profile/my_profile.dart';
// import '../repositories/api/api_constants.dart';
// import '../utils/slider_page_data_model.dart';

// class HomeMainScreen extends StatefulWidget {
//   const HomeMainScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeMainScreen> createState() => _HomeMainScreenState();
// }

// class _HomeMainScreenState extends State<HomeMainScreen> {
//   // int currentvalue = 0;
//   List userDetail = Utils.getUser();

//   HomeMainController controller = Get.put(HomeMainController());
//   ReelController reelController = Get.put(ReelController());
//   final UserProfileController userProfileController = Get.put(UserProfileController());

//   @override
//   void initState() {
//     reelController.getReels();
//     controller.feedbackApi();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeMainController>(
//       init: HomeMainController(),
//       builder: (controller) => Scaffold(
//         body: _body(),
//         bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22)),
//               boxShadow: [
//                 BoxShadow(color: const Color(0XFF503494).withOpacity(0.12), spreadRadius: 0, blurRadius: 12),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(22.0),
//                 topRight: Radius.circular(22.0),
//               ),
//               child: BottomNavigationBar(
//                   backgroundColor: const Color(0XFFFFFFFF),
//                   currentIndex: controller.position.value,
//                   onTap: (index) {
//                     // setState(() {
//                     //   currentvalue = index;
//                     // });
//                     controller.onChange(index);
//                   },
//                   type: BottomNavigationBarType.fixed,
//                   selectedItemColor: Color(0XFF503494),
//                   selectedIconTheme: IconThemeData(color: Color(0XFF503494)),
//                   items: [
//                     BottomNavigationBarItem(
//                         activeIcon: Column(
//                           children: const [
//                             Image(
//                               image: AssetImage("assets/bottomhomeblue.png"),
//                               height: 24,
//                               width: 24,
//                               color: Color(0XFF503494),
//                             ),
//                             SizedBox(height: 8.79),
//                             Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
//                           ],
//                         ),
//                         icon: const Image(
//                           image: AssetImage("assets/bottomhomeblack.png"),
//                           height: 24,
//                           width: 24,
//                         ),
//                         label: 'Home'),
//                     BottomNavigationBarItem(
//                         activeIcon: Column(
//                           children: const [
//                             Image(
//                               image: AssetImage("assets/homework.png"),
//                               height: 24,
//                               width: 24,
//                               color: Color(0XFF503494),
//                             ),
//                             SizedBox(height: 8.79),
//                             Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
//                           ],
//                         ),
//                         icon: const Image(
//                           image: AssetImage("assets/homework.png"),
//                           height: 24,
//                           width: 24,
//                         ),
//                         label: 'Courses'),
//                     BottomNavigationBarItem(
//                         activeIcon: Column(
//                           children: const [
//                             Image(image: AssetImage("assets/bottomhomeblue.png"), height: 24, width: 24, color: Color(0XFF503494)),
//                             SizedBox(height: 8.79),
//                             Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
//                           ],
//                         ),
//                         icon: const Image(
//                           image: AssetImage("assets/bottomhomeblack.png"),
//                           height: 24,
//                           width: 24,
//                         ),
//                         label: 'Batch'),
//                     BottomNavigationBarItem(
//                         activeIcon: Column(
//                           children: const [
//                             Image(image: AssetImage("assets/bottombookblue.png"), height: 24, width: 24, color: Color(0XFF503494)),
//                             SizedBox(height: 8.79),
//                             Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
//                           ],
//                         ),
//                         icon: const Image(image: AssetImage("assets/bottombookblack.png"), height: 24, width: 24),
//                         label: 'Jobs'),
//                     BottomNavigationBarItem(
//                         activeIcon: Column(
//                           children: const [
//                             Image(image: AssetImage("assets/bottommessegeblue.png"), height: 24, width: 24, color: Color(0XFF503494)),
//                             SizedBox(height: 8.79),
//                             Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
//                           ],
//                         ),
//                         icon: const Image(image: AssetImage("assets/store.png"), height: 24, width: 24),
//                         label: 'Store'),
//                     BottomNavigationBarItem(
//                         activeIcon: Column(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: CachedNetworkImage(
//                                 fit: BoxFit.cover,
//                                 height: 24.h,
//                                 width: 24.h,
//                                 imageUrl: "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
//                                 progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                                   child: Container(
//                                     height: 24.h,
//                                     width: 24.h,
//                                     child: CircularProgressIndicator(value: downloadProgress.progress),
//                                   ),
//                                 ),
//                                 errorWidget: (context, url, error) => ClipRRect(
//                                   borderRadius: BorderRadius.circular(10.h),
//                                   child: Container(
//                                     height: 24.h,
//                                     width: 24.h,
//                                     color: Colors.grey.withOpacity(0.2),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8.79),
//                             Image(image: AssetImage("assets/line.png"), height: 1.75, width: 24),
//                           ],
//                         ),
//                         icon: ClipRRect(
//                           borderRadius: BorderRadius.circular(50),
//                           child: CachedNetworkImage(
//                             fit: BoxFit.cover,
//                             height: 24.h,
//                             width: 24.h,
//                             imageUrl: "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
//                             progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                               child: Container(
//                                 height: 24.h,
//                                 width: 24.h,
//                                 child: CircularProgressIndicator(value: downloadProgress.progress),
//                               ),
//                             ),
//                             errorWidget: (context, url, error) => ClipRRect(
//                               borderRadius: BorderRadius.circular(10.h),
//                               child: Container(
//                                 height: 24.h,
//                                 width: 24.h,
//                                 color: Colors.grey.withOpacity(0.2),
//                               ),
//                             ),
//                           ),
//                         ),
//                         label: 'Account'),
//                   ]),
//             )),
//       ),
//     );
//   }

//   _body() {
//     switch (controller.position.value) {
//       case 0:
//         //return Center(child: Container(child: Text("1")));
//         return ReelsHome();
//       case 1:
//         return HomeScreen();
//       // return CourseListPage();
//       case 2:
//         //return Center(child: Container(child: Text("1")));
//         return BatchesScreen();
//       case 3:
//         //return Center(child: Container(child: Text("2")));
//         return JobListScreen();
//       case 4:
//         //return Center(child: Container(child: Text("3")));
//         return const WebviewStore();
//       case 5:
//         return MyProfile();
//       case 6:
//         return MyProfile();

//       default:
//         return const Center(
//           child: Text("inavalid"),
//         );
//     }
//   }
// }

///Curved Navigation Bar

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:edxera/batchs/batches_main_screen.dart';
// import 'package:edxera/homes/homes.dart';
// import 'package:edxera/jobs/job_list_view.dart';
// import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
// import 'package:edxera/profile/my_profile.dart';
// import 'package:edxera/reels/controller/reel_controller.dart';
// import 'package:edxera/reels/reels_home.dart';
// import 'package:edxera/store/webview_store.dart';
// import 'package:edxera/trending.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:edxera/controller/controller.dart';
// import 'package:edxera/home/home_screen.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import the package
// import '../repositories/api/api_constants.dart';
// import '../utils/slider_page_data_model.dart';

// class HomeMainScreen extends StatefulWidget {
//   const HomeMainScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeMainScreen> createState() => _HomeMainScreenState();
// }

// class _HomeMainScreenState extends State<HomeMainScreen> {
//   List userDetail = Utils.getUser();

//   HomeMainController controller = Get.put(HomeMainController());
//   ReelController reelController = Get.put(ReelController());
//   final UserProfileController userProfileController =
//       Get.put(UserProfileController());

//   @override
//   void initState() {
//     reelController.getReels();
//     controller.feedbackApi();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeMainController>(
//       init: HomeMainController(),
//       builder: (controller) => Scaffold(
//         body: _body(),
//         bottomNavigationBar: CurvedNavigationBar(
//           // Use CurvedNavigationBar
//           backgroundColor:
//               Colors.purple.shade900, // Set background to transparent
//           color: Colors.white, // Set navigation bar color
//           // buttonBackgroundColor: Color(0XFF503494), // Active button color
//           height: 60.h,
//           index: controller.position.value,
//           items: <Widget>[
//             _buildNavItem(
//                 // Icons.home,
//                 // Icons.home,
//                 "assets/bottomhomeblack.png",
//                 "assets/bottomhomeblue.png",
//                 0),
//             _buildNavItem(
//                 // Icons.book,
//                 // Icons.book,
//                 "assets/homework.png",
//                 "assets/homework.png",
//                 1),
//             _buildNavItem(
//                 // Icons.batch_prediction,
//                 // Icons.batch_prediction,
//                 "assets/bottomhomeblack.png",
//                 "assets/bottomhomeblue.png",
//                 2),
//             _buildNavItem('assets/film-reel.png', 'assets/film-reel.png', 3),
//             _buildNavItem(
//                 // Icons.work,
//                 // Icons.work,
//                 "assets/bottombookblack.png",
//                 "assets/bottombookblue.png",
//                 4),
//             _buildNavItem(
//                 // Icons.store,
//                 // Icons.store,
//                 "assets/store.png",
//                 "assets/bottommessegeblue.png",
//                 5),
//             _buildProfileNavItem(),
//           ],
//           onTap: (index) {
//             controller.onChange(index);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(String icon, String activeIcon, int index) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Icon(
//         //   controller.position.value == index ? activeIcon : icon,
//         //   size: 24.h,
//         //   // color: controller.position.value == index
//         //   //     ? Color(0XFF503494)
//         //   //     : Colors.black,
//         // ),
//         Image(
//           image: AssetImage(
//               controller.position.value == index ? activeIcon : icon),
//           height: 24.h,
//           width: 24.h,
//           color: controller.position.value == index ? Colors.black : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildProfileNavItem() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(50),
//           child: CachedNetworkImage(
//             fit: BoxFit.cover,
//             height: 24.h,
//             width: 24.h,
//             imageUrl:
//                 "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
//             progressIndicatorBuilder: (context, url, downloadProgress) =>
//                 Center(
//               child: Container(
//                 height: 24.h,
//                 width: 24.h,
//                 child:
//                     CircularProgressIndicator(value: downloadProgress.progress),
//               ),
//             ),
//             errorWidget: (context, url, error) => ClipRRect(
//               borderRadius: BorderRadius.circular(10.h),
//               child: Container(
//                 height: 24.h,
//                 width: 24.h,
//                 color: Colors.grey.withOpacity(0.2),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   _body() {
//     switch (controller.position.value) {
//       case 0:
//         return TrendingScreen();
//       case 1:
//         return HomeScreen();
//       case 2:
//         return BatchesScreen();
//       case 3:
//         return ReelsHome();
//       case 4:
//         return JobListScreen();
//       case 5:
//         return const WebviewStore();
//       case 6:
//         return MyProfile();
//       default:
//         return const Center(
//           child: Text("inavalid"),
//         );
//     }
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/batchs/batches_main_screen.dart';
import 'package:edxera/home/trending.dart';
import 'package:edxera/home/trending/trending_home_reel.dart';
import 'package:edxera/homes/homes.dart';
import 'package:edxera/jobs/job_list_view.dart';
import 'package:edxera/profile/Controllers/profile_controller/profile_conreoller.dart';
import 'package:edxera/profile/my_profile.dart';
import 'package:edxera/reels/controller/reel_controller.dart';
import 'package:edxera/reels/reels_home.dart';
import 'package:edxera/store/webview_store.dart';
import 'package:edxera/home/trending/trending_reel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/home/home_screen.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart'; // Import spincircle_bottom_bar package
import '../repositories/api/api_constants.dart';
import '../utils/slider_page_data_model.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  List userDetail = Utils.getUser();

  HomeMainController controller = Get.put(HomeMainController());
  ReelController reelController = Get.put(ReelController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

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
      builder: (controller) => SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
            circleColors: [Colors.white, Colors.purple, Colors.redAccent],
            iconTheme: IconThemeData(color: Colors.black45),
            activeIconTheme: IconThemeData(color: Colors.purple),
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black45, fontSize: 12),
            activeTitleStyle: TextStyle(
                color: Colors.purple,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(
                color: Colors.redAccent,
                icon: Icon(
                  Icons.expand_less,
                  color: Colors.white,
                ),
                elevation: 2),
            elevation: 2.0,
            items: [
              SCBottomBarItem(
                icon: Icons.home,
                // title: "",
                onPressed: () => controller.onChange(0),
              ),
              SCBottomBarItem(
                icon: Icons.book,
                // title: "",
                onPressed: () => controller.onChange(1),
              ),
              SCBottomBarItem(
                icon: Icons.batch_prediction,
                // title: "",
                onPressed: () => controller.onChange(2),
              ),
              // SCBottomBarItem(
              //   icon: Icons.movie,
              //   // title: "",
              //   onPressed: () => controller.onChange(3),
              // ),
              SCBottomBarItem(
                icon: Icons.work,
                // title: "",
                onPressed: () => controller.onChange(4),
              ),
              SCBottomBarItem(
                icon: Icons.store,
                // title: "",
                onPressed: () => controller.onChange(5),
              ),
              SCBottomBarItem(
                icon: Icons.person,
                // title: "",
                onPressed: () => controller.onChange(6),
              ),
            ],
            circleItems: [
              //Suggested Count: 3
              SCItem(
                icon: Icon(Icons.video_collection_sharp),
                // title: "",
                onPressed: () => controller.onChange(3),
              ),

              // SCItem(
              //     icon: Icon(Icons.print),
              //     onPressed: () {
              //       print("onPressed");
              //     }),
              // SCItem(
              //     icon: Icon(Icons.map),
              //     onPressed: () {
              //       print("onPressed");
              //     }),
            ]),
        child: _body(),
      ),
    );
  }

  Widget _buildNavItem(String icon, String activeIcon, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: AssetImage(
              controller.position.value == index ? activeIcon : icon),
          height: 24.h,
          width: 24.h,
          color: controller.position.value == index ? Colors.black : null,
        ),
      ],
    );
  }

  Widget _buildProfileNavItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            height: 24.h,
            width: 24.h,
            imageUrl:
                "${ApiConstants.publicBaseUrl}/${userProfileController.userProfile.value?.data?.profileImage ?? ''}",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: Container(
                height: 24.h,
                width: 24.h,
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
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
      ],
    );
  }

  _body() {
    switch (controller.position.value) {
      case 0:
        return TrendingScreen();
      case 1:
        return HomeScreen();
      case 2:
        return BatchesScreen();
      case 3:
        return ReelsHome();
      case 4:
        return JobListScreen();
      case 5:
        return const WebviewStore();
      case 6:
        return MyProfile();
      default:
        return const Center(
          child: Text("inavalid"),
        );
    }
  }
}
