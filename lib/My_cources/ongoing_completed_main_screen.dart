// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:edxera/controller/controller.dart';

// import '../languagecontrols/LanguageCheck.dart';
// import '../utils/screen_size.dart';
// import '../utils/shared_pref.dart';
// import 'completed_screen.dart';
// import 'ongoing_screen.dart';

// class OngoingCompletedScreen extends StatefulWidget {
//   const OngoingCompletedScreen({Key? key}) : super(key: key);

//   @override
//   State<OngoingCompletedScreen> createState() => _OngoingCompletedScreenState();
// }

// class _OngoingCompletedScreenState extends State<OngoingCompletedScreen> with TickerProviderStateMixin {
//   OngoingCompletedController ongoingCompletedController = Get.put(OngoingCompletedController());
//   PageController pageController = PageController();
//   List courcesClass = [OngoingScreen(), CompletedScreen()];
//   int initialValue = 0;
//   late TabController tabController;
//   Map<String, dynamic> mplanguage = new HashMap();
//   @override
//   void initState() {
//     tabController = TabController(
//       length: 2,
//       vsync: this,
//     );

//     super.initState();
//     checkLanguage();
//   }

//   checkLanguage() async {
//     String lcode = await PrefData.getLanguage();

//     var b = await LanguageCheck.checkLanguage(lcode);
//     setState(() {
//       mplanguage = b;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     initializeScreenSize(context);
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 73.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.h),
//             child: Row(
//               children: [
//                 // GestureDetector(
//                 //     onTap: () {
//                 //       SystemChannels.platform
//                 //           .invokeMethod('SystemNavigator.pop');
//                 //     },
//                 //     child: Image(
//                 //       image: const AssetImage("assets/back_arrow.png"),
//                 //       height: 24.h,
//                 //       width: 24.w,
//                 //     )),
//                 // SizedBox(width: 16.w),
//                 Text(
//                   mplanguage['mycourses'].toString(),
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Container(
//               height: 54,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(22.h),
//                   boxShadow: [
//                     BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
//                   ],
//                   color: Colors.white),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                 child: TabBar(
//                   unselectedLabelColor: Color(0XFF6E758A),
//                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
//                   labelStyle: TextStyle(color: Color(0XFF503494), fontWeight: FontWeight.bold, fontSize: 15.sp, fontFamily: 'Gilroy'),
//                   labelColor: const Color(0XFF503494),
//                   unselectedLabelStyle: TextStyle(color: Color(0XFF503494), fontWeight: FontWeight.bold, fontSize: 15.sp, fontFamily: 'Gilroy'),
//                   indicator:
//                       ShapeDecoration(color: const Color(0XFFE5ECFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.h))),
//                   controller: tabController,
//                   tabs: [
//                     Tab(
//                       text: mplanguage['ongoing'].toString(),
//                     ),
//                     Tab(
//                       text: mplanguage['completed'].toString(),
//                     ),
//                   ],
//                   onTap: (value) {
//                     initialValue = value;
//                     setState(() {});
//                   },
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Expanded(
//             flex: 1,
//             child: courcesClass[initialValue],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
