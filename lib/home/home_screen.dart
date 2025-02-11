// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:edxera/My_cources/lesson_play.dart';
// import 'package:edxera/batchs/BatchDetailsScreen/Modules/add_btach_view_screen.dart';
// import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_description_screen.dart';
// import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_mcq_screen.dart';
// import 'package:edxera/batchs/BatchDetailsScreen/Modules/lesson_details_screen.dart';
// import 'package:edxera/batchs/BatchDetailsScreen/Modules/study_plan_assigment_screen.dart';
// import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
// import 'package:edxera/batchs/controllers/lesson_details_controller.dart';
// import 'package:edxera/course_list/course_list_controller.dart';
// import 'package:edxera/home/all_categories_screen.dart';
// import 'package:edxera/home/categorey_wise_subject_screen.dart';
// import 'package:edxera/home/free_study_matrial_view_screen.dart';
// import 'package:edxera/home/notification_screen.dart';
// import 'package:edxera/home/sub_categories_screen.dart';
// import 'package:edxera/home/testimonials_widget.dart';
// import 'package:edxera/profile/edit_screen.dart';
// import 'package:edxera/utils/shared_pref.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:edxera/controller/controller.dart';
// import 'package:edxera/cources/cources.dart';
// import 'package:edxera/home/recent_added_cource_detail.dart';
// import 'package:edxera/home/trending_cource.dart';
// import 'package:edxera/models/recently_added.dart';
// import 'package:edxera/models/trending_cource.dart';
// import 'package:edxera/utils/slider_page_data_model.dart';
// import '../languagecontrols/LanguageCheck.dart';
// import '../login/login_empty_state.dart';
// import '../repositories/api/api_constants.dart';
// import '../repositories/post_repository.dart';
// import '../utils/screen_size.dart';
// import 'package:badges/badges.dart' as badges;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   List<Trending> trendingCource = Utils.getTrending();
//   List<Recent> recentAdded = Utils.getRecentAdded();
//   HomeController homecontroller = Get.put(HomeController());
//   final CourseController courseController = Get.put(CourseController());
//   LessonDetailsController lessonDetailsController =
//       Get.put(LessonDetailsController());

//   // int currentpage = 0;
//   PageController controller = PageController();
//   bool buttonvalue = false;
//   int currentvalue = 0;
//   List userDetail = Utils.getUser();
//   Map<String, dynamic> mplanguage = new HashMap();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       // PostRepository postRepository = PostRepository();
//       // final isUserExit = await postRepository.checkUserExist();
//       //
//       // if (isUserExit) {
//       homecontroller.userDataApi();
//       homecontroller.notificationCountDataApi();
//       homecontroller.homeDashboardDatGetApi();
//       homecontroller.homeCategoryDataGetApi();
//       homecontroller.getFreeCourses();
//       homecontroller.homeDashboardTrendingDatGetApi();
//       homecontroller.homeDashboardTestimonailasDatGetApi();
//       homecontroller.homeDashboardStudyPlansDatGetApi();
//       // } else {
//       //   Get.offAll(() => const EmptyState());
//       // }
//     });

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

//   toggle(int index) {
//     setState(() {
//       if (trendingCource[index].buttonStatus == true) {
//         trendingCource[index].buttonStatus = false;
//       } else {
//         trendingCource[index].buttonStatus = true;
//       }
//     });
//   }

//   toggleRecent(int index) {
//     setState(() {
//       if (recentAdded[index].buttonStatus == true) {
//         recentAdded[index].buttonStatus = false;
//       } else {
//         recentAdded[index].buttonStatus = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     initializeScreenSize(context);
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(56), // Set a fixed height for the AppBar
//         child: AppBar(
//           backgroundColor: Colors.white,
//           title: isSearching
//               ? Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   child: TextField(
//                     controller: searchController,
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       hintText: "Search...",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                       isDense: true,
//                     ),
//                     style: TextStyle(
//                         color: Colors.black), // Set text color to black
//                   ),
//                 )
//               : Row(
//                   children: [
//                     Image.asset(
//                       'assets/app_logo.jpeg', // Your logo image
//                       height: 30,
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       "Edxera",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.purple.shade900),
//                     ),
//                   ],
//                 ),
//           actions: [
//             isSearching
//                 ? IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () {
//                       setState(() {
//                         isSearching = false;
//                         searchController.clear();
//                       });
//                     },
//                   )
//                 : IconButton(
//                     icon: Icon(Icons.search),
//                     onPressed: () {
//                       setState(() {
//                         isSearching = true;
//                       });
//                     },
//                   ),
//           ],
//         ),
//       ),
//       body: Obx(
//         () => Stack(
//           children: [
//             SafeArea(
//               child: SizedBox(
//                 height: double.infinity,
//                 width: double.infinity,
//                 child: GetBuilder<HomeController>(
//                   init: HomeController(),
//                   builder: (controller) => SafeArea(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 16.h),

//                         Divider(),
//                         Expanded(
//                           child: ListView(
//                             // physics: BouncingScrollPhysics(),
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             primary: true,
//                             children: [

//                               Obx(
//                                 () => homecontroller
//                                             .homeDashboardDataModel.data !=
//                                         null
//                                     ? generatepage()
//                                     : Container(),
//                               ),
//                               // SizedBox(height: 20.h),
//                               indicator(),
//                               SizedBox(height: 20.h),
//                               Column(
//                                 children: [
//                                   if (homecontroller.countries.isEmpty)
//                                     ...[]
//                                   else ...[
//                                     Container(
//                                       width: double.infinity,
//                                       margin: EdgeInsets.only(
//                                           left: 10.w, right: 10.w),
//                                       decoration: BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: const Color(0XFF503494)
//                                                   .withOpacity(0.14),
//                                               offset: const Offset(-4, 5),
//                                               blurRadius: 16),
//                                         ],
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 10.w, right: 10.w),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Image.asset(
//                                                   'assets/lesson1.png',
//                                                   height: 66.h,
//                                                   width: 66.w,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10.h,
//                                                 ),
//                                                 Expanded(
//                                                   child: (homecontroller
//                                                                   .countries !=
//                                                               [] ||
//                                                           homecontroller
//                                                               .countries
//                                                               .isNotEmpty)
//                                                       ? Theme(
//                                                           data: ThemeData(
//                                                             textTheme: TextTheme(
//                                                                 titleMedium: TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                         15.sp,
//                                                                     fontFamily:
//                                                                         'Gilroy',
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400)),
//                                                           ),
//                                                           child: DropdownSearch<
//                                                               String>(
//                                                             popupProps:
//                                                                 PopupProps.menu(
//                                                               showSearchBox:
//                                                                   true,
//                                                               showSelectedItems:
//                                                                   true,
//                                                               disabledItemFn:
//                                                                   (String s) =>
//                                                                       s.startsWith(
//                                                                           'I'),
//                                                             ),
//                                                             items:
//                                                                 homecontroller
//                                                                     .countries,
//                                                             dropdownDecoratorProps:
//                                                                 DropDownDecoratorProps(
//                                                               baseStyle: TextStyle(
//                                                                   color: Colors
//                                                                       .black,
//                                                                   fontSize:
//                                                                       15.sp,
//                                                                   fontFamily:
//                                                                       'Gilroy',
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400),
//                                                               dropdownSearchDecoration:
//                                                                   InputDecoration(
//                                                                 labelStyle: TextStyle(
//                                                                     color: Color(
//                                                                         0XFF9B9B9B),
//                                                                     fontSize:
//                                                                         15.sp,
//                                                                     fontFamily:
//                                                                         'Gilroy',
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400),
//                                                                 enabledBorder:
//                                                                     UnderlineInputBorder(
//                                                                   borderSide:
//                                                                       BorderSide(
//                                                                           color:
//                                                                               Colors.black),
//                                                                 ),
//                                                                 focusedBorder:
//                                                                     UnderlineInputBorder(
//                                                                   borderSide:
//                                                                       BorderSide(
//                                                                           color:
//                                                                               Colors.black),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             onChanged: (value) {
//                                                               homecontroller
//                                                                       .dropdownvalue
//                                                                       .value =
//                                                                   value ?? '';
//                                                               for (var element
//                                                                   in homecontroller
//                                                                           .studyPlanCourseNameDataModel
//                                                                           .data
//                                                                           ?.userCourses ??
//                                                                       []) {
//                                                                 if (element
//                                                                         .courseTitle ==
//                                                                     value) {
//                                                                   homecontroller
//                                                                           .batchid
//                                                                           .value =
//                                                                       element
//                                                                           .batchId
//                                                                           .toString();
//                                                                   print(element
//                                                                       .batchId);
//                                                                   PrefData.setCourseID(
//                                                                       element
//                                                                           .batchId
//                                                                           .toString());
//                                                                   PrefData.setCourseName(
//                                                                       value ??
//                                                                           '');
//                                                                   homecontroller
//                                                                       .getTodayStudyPlan(element
//                                                                           .batchId
//                                                                           .toString())
//                                                                       .then(
//                                                                           (value) {

//                                                                     setState(
//                                                                         () {});
//                                                                     // });
//                                                                   });
//                                                                 }
//                                                               }
//                                                             },
//                                                             onSaved:
//                                                                 (newValue) {

//                                                             },
//                                                             selectedItem:
//                                                                 homecontroller
//                                                                     .dropdownvalue
//                                                                     .value,
//                                                           ),
//                                                         )
//                                                       : Container(),
//                                                 ),
//                                               ],
//                                             ),

//                                             SizedBox(
//                                               height: 20.h,
//                                             ),

//                                             SizedBox(
//                                               height: 20.h,
//                                             ),
//                                             Obx(
//                                               () => Text(
//                                                 homecontroller
//                                                     .dropdownvalue.value,
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 20.sp,
//                                                     color: Colors.black),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                   SizedBox(height: 20.h),
//                                   if ((homecontroller.todaysStudyPlanDataModel
//                                               .data?.studyPlans?.length ??
//                                           0) >
//                                       0) ...[
//                                     Container(
//                                       width: double.infinity,
//                                       margin: EdgeInsets.only(
//                                           left: 10.w, right: 10.w),
//                                       decoration: BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: const Color(0XFF503494)
//                                                   .withOpacity(0.14),
//                                               offset: const Offset(-4, 5),
//                                               blurRadius: 16),
//                                         ],
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 10.w, right: 10.w),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             if ((homecontroller
//                                                         .todaysStudyPlanDataModel
//                                                         .data
//                                                         ?.studyPlans
//                                                         ?.length ??
//                                                     0) >
//                                                 0)
//                                               SizedBox(
//                                                 height: 20.h,
//                                               ),
//                                             if ((homecontroller
//                                                         .todaysStudyPlanDataModel
//                                                         .data
//                                                         ?.studyPlans
//                                                         ?.length ??
//                                                     0) >
//                                                 0)
//                                               homecontroller
//                                                           .todaysStudyPlanDataModel
//                                                           .data
//                                                           ?.studyPlans !=
//                                                       null
//                                                   ? Obx(() => ListView.builder(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(10),
//                                                         itemCount: homecontroller
//                                                             .todaysStudyPlanDataModel
//                                                             .data
//                                                             ?.studyPlans?[0]
//                                                             .items
//                                                             ?.length,
//                                                         shrinkWrap: true,
//                                                         physics:
//                                                             NeverScrollableScrollPhysics(),
//                                                         itemBuilder:
//                                                             (context, indexs) {
//                                                           return GestureDetector(
//                                                             onTap: () {
//                                                               if ((homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .type ??
//                                                                       '') ==
//                                                                   'EXAM_MCQ') {
//                                                                 Get.to(
//                                                                     ExamMcqScreen(
//                                                                   examPogress: homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .progressStatus ??
//                                                                       '',
//                                                                   title: homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .title ??
//                                                                       '',
//                                                                   examid: (homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .examId ??
//                                                                           0)
//                                                                       .toString(),
//                                                                   studyPlanId: (homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .fkIntStudyPlanItemsId ??
//                                                                           0)
//                                                                       .toString(),
//                                                                 ));
//                                                               } else if ((homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .type ??
//                                                                       '') ==
//                                                                   'EXAM_DESCRIPTION') {
//                                                                 Get.to(
//                                                                     ExamDescriptionScreen(
//                                                                   examPogress: homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .progressStatus ??
//                                                                       '',
//                                                                   title: homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .title ??
//                                                                       '',
//                                                                   examid: (homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .examId ??
//                                                                           0)
//                                                                       .toString(),
//                                                                   studyPlanId: (homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .fkIntStudyPlanItemsId ??
//                                                                           0)
//                                                                       .toString(),
//                                                                 ));
//                                                               } else if ((homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .type ??
//                                                                       '') ==
//                                                                   'ASSIGMENT') {
//                                                                 Get.to(
//                                                                     StudyPlanAssigmentScreen(
//                                                                   title: homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .title ??
//                                                                       '',
//                                                                   assigmentid: (homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .assigmentId ??
//                                                                           0)
//                                                                       .toString(),
//                                                                   studyPlanId: (homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .fkIntStudyPlanItemsId ??
//                                                                           0)
//                                                                       .toString(),
//                                                                 ));
//                                                               } else if ((homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .type ??
//                                                                       '') ==
//                                                                   'DIRECT_VIDEO') {
//                                                                 if ((homecontroller
//                                                                             .todaysStudyPlanDataModel
//                                                                             .data
//                                                                             ?.studyPlans?[0]
//                                                                             .items?[indexs]
//                                                                             .dvVideoFile ??
//                                                                         '') !=
//                                                                     '') {
//                                                                   var dataVIdeo = jsonDecode(homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .dvVideoFile ??
//                                                                       '');
//                                                                   print(dataVIdeo[
//                                                                       "video"]);

//                                                                   Navigator
//                                                                       .push(
//                                                                     context,
//                                                                     MaterialPageRoute(
//                                                                       builder: (context) =>
//                                                                           VidioPlay(
//                                                                               lessonplay: '${ApiConstants.publicBaseUrl}/${dataVIdeo["video"]}'),
//                                                                     ),
//                                                                   );
//                                                                 } else {
//                                                                   Get.to(() => YoutubeVideoPlayerScreen(
//                                                                       url: homecontroller
//                                                                               .todaysStudyPlanDataModel
//                                                                               .data
//                                                                               ?.studyPlans?[0]
//                                                                               .items?[indexs]
//                                                                               .dvYoutubeLink ??
//                                                                           ''));
//                                                                 }
//                                                               } else if ((homecontroller
//                                                                           .todaysStudyPlanDataModel
//                                                                           .data
//                                                                           ?.studyPlans?[
//                                                                               0]
//                                                                           .items?[
//                                                                               indexs]
//                                                                           .type ??
//                                                                       '') ==
//                                                                   'CHAPTER') {
//                                                                 homecontroller.chepterInnerApiCall(
//                                                                     (homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].chapterId ??
//                                                                             0)
//                                                                         .toString(),
//                                                                     (homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].pkIntStudyPlanItemsId ??
//                                                                             '')
//                                                                         .toString());
//                                                               }
//                                                             },
//                                                             child: (homecontroller
//                                                                             .todaysStudyPlanDataModel
//                                                                             .data
//                                                                             ?.studyPlans?[0]
//                                                                             .items?[indexs]
//                                                                             .type ??
//                                                                         '') ==
//                                                                     'CHAPTER'
//                                                                 ? Padding(
//                                                                     padding: const EdgeInsets
//                                                                         .only(
//                                                                         bottom:
//                                                                             20),
//                                                                     child:
//                                                                         ListTile(
//                                                                       leading:
//                                                                           Container(
//                                                                         height:
//                                                                             60.h,
//                                                                         width:
//                                                                             60.w,
//                                                                         decoration:
//                                                                             BoxDecoration(
//                                                                           color:
//                                                                               Colors.grey[200],
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(10),
//                                                                         ),
//                                                                         child:
//                                                                             Column(
//                                                                           children: [
//                                                                             Container(
//                                                                               width: double.infinity,
//                                                                               alignment: Alignment.center,
//                                                                               decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
//                                                                               height: 20.h,
//                                                                               child: Text(
//                                                                                 mplanguage['day'].toString(),
//                                                                                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.white),
//                                                                               ),
//                                                                             ),
//                                                                             Expanded(
//                                                                               child: Container(
//                                                                                 width: double.infinity,
//                                                                                 alignment: Alignment.center,
//                                                                                 decoration: BoxDecoration(),
//                                                                                 child: Text(
//                                                                                   homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].studyPlansDate?.split('-').last ?? '',
//                                                                                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
//                                                                                 ),
//                                                                               ),
//                                                                             )
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                       title:
//                                                                           Text(
//                                                                         homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].title ??
//                                                                             '',
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.w700,
//                                                                             fontSize: 20.sp,
//                                                                             color: Colors.black),
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                                 : Container(
//                                                                     margin: EdgeInsets.only(
//                                                                         bottom:
//                                                                             20),
//                                                                     child:
//                                                                         ListTile(
//                                                                       leading:
//                                                                           Container(
//                                                                         height:
//                                                                             60.h,
//                                                                         width:
//                                                                             60.w,
//                                                                         decoration:
//                                                                             BoxDecoration(
//                                                                           color: Colors
//                                                                               .blue
//                                                                               .withOpacity(0.2),
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(10),
//                                                                         ),
//                                                                         child:
//                                                                             Icon(
//                                                                           Icons
//                                                                               .play_circle,
//                                                                           color:
//                                                                               Colors.blue,
//                                                                           size:
//                                                                               40,
//                                                                         ),
//                                                                       ),
//                                                                       title:
//                                                                           Text(
//                                                                         homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].title ??
//                                                                             '',
//                                                                         maxLines:
//                                                                             2,
//                                                                         style: TextStyle(
//                                                                             overflow:
//                                                                                 TextOverflow.ellipsis,
//                                                                             fontWeight: FontWeight.w700,
//                                                                             fontSize: 15.sp,
//                                                                             color: Colors.black),
//                                                                       ),
//                                                                       subtitle:
//                                                                           Text(
//                                                                         mplanguage['progress'].toString() +
//                                                                             ':${homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].progressStatus ?? ''}',
//                                                                         maxLines:
//                                                                             2,
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.w500,
//                                                                             overflow: TextOverflow.ellipsis,
//                                                                             fontSize: 14.sp,
//                                                                             color: Colors.grey),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                           );
//                                                         },
//                                                       ))
//                                                   : Container(
//                                                       child: Center(
//                                                         child: Text(
//                                                           mplanguage['nodata']
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.black,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700),
//                                                         ),
//                                                       ),
//                                                     ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20.h,
//                                     ),
//                                   ],
//                                   if (!homecontroller.isStudyPlan.value)
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 LessonDetailsScreens(
//                                               batchId:
//                                                   homecontroller.batchid.value,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(50.h / 2),
//                                           color: const Color(0XFF503494),
//                                         ),
//                                         height: 50.h,
//                                         margin: EdgeInsets.only(
//                                             left: 30.w, right: 30.w),
//                                         child: Text(
//                                           mplanguage['viewstudyplan']
//                                               .toString(),
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 20.sp,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               Obx(
//                                 () => homecontroller
//                                             .homeDashboardDataModel.data !=
//                                         null
//                                     ? horizontal_disidn()
//                                     : Container(),
//                               ),
//                               SizedBox(height: 30.h),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                 child: Text(
//                                     mplanguage["batchsuccessfull"].toString(),
//                                     style: TextStyle(
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.w700,
//                                         fontFamily: 'Gilroy')),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     bottom: 20.h,
//                                     top: 15.h,
//                                     left: 8.w,
//                                     right: 8.w),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             AddBatchViewScreen(),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     width: double.infinity.w,
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                             image: AssetImage(
//                                                 'assets/batchImages.jpg'),
//                                             fit: BoxFit.fill),
//                                         borderRadius: BorderRadius.circular(12),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: const Color(0XFF503494)
//                                                   .withOpacity(0.14),
//                                               offset: const Offset(-4, 5),
//                                               blurRadius: 16),
//                                         ],
//                                         color: Colors.white),
//                                     child: Container(
//                                       decoration: BoxDecoration(),
//                                       margin: EdgeInsets.all(15.w),
//                                       child: Container(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(height: 10.w),
//                                             Text(
//                                               mplanguage['reqtutor'].toString(),
//                                               style: TextStyle(
//                                                   fontSize: 15.sp,
//                                                   fontFamily: 'Gilroy',
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             SizedBox(height: 10.w),
//                                             Container(
//                                               height: 40.h,
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   1.8,
//                                               //color: Color(0XFF503494),
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(5.h),
//                                                 color: const Color(0XFF503494),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                     mplanguage["sendjoin"]
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         color:
//                                                             Color(0XFFFFFFFF),
//                                                         fontSize: 18.sp,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         fontFamily: 'Gilroy')),
//                                               ),
//                                             ),
//                                             SizedBox(height: 10.w),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Padding(
//                               //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               //   child: Row(
//                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               //     children: [
//                               //       Text(mplanguage['trendingc'].toString(),
//                               //           style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
//                               //       TextButton(
//                               //           onPressed: () {
//                               //             Get.to(const TrendingCource());
//                               //           },
//                               //           child: Text(mplanguage['seeall'].toString(),
//                               //               style: TextStyle(
//                               //                   fontSize: 13.sp, fontFamily: 'Gilroy', color: const Color(0XFF503494), fontWeight: FontWeight.bold)))
//                               //     ],
//                               //   ),
//                               // ),
//                               // Obx(
//                               //   () => homecontroller.trendingCoursesDataModel.data != null ? trending_cource_list() : Container(),
//                               // ),
//                               // Padding(
//                               //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               //   child: Text("Free Study Matrial",
//                               //       style: TextStyle(
//                               //           fontSize: 18.sp,
//                               //           fontWeight: FontWeight.w700,
//                               //           fontFamily: 'Gilroy')),
//                               // ),
//                               SizedBox(height: 10.h),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 20.w, vertical: 10.h),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Learning that fits",
//                                         style: TextStyle(
//                                             fontSize: 28.sp,
//                                             fontWeight: FontWeight.w700,
//                                             fontFamily: 'Gilroy')),
//                                     Text("Skills for your present (and future)",
//                                         style: TextStyle(
//                                             fontSize: 16.sp,
//                                             fontWeight: FontWeight.w700,
//                                             fontFamily: 'Gilroy')),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 20.w, vertical: 10.h),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Categories",
//                                       style: TextStyle(
//                                           fontSize: 13.sp,
//                                           fontWeight: FontWeight.w700,
//                                           fontFamily: 'Gilroy'),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.to(
//                                           AllCategoriesScreen(),
//                                         );
//                                       },
//                                       child: Text(
//                                         "See all",
//                                         style: TextStyle(
//                                             fontSize: 13.sp,
//                                             fontWeight: FontWeight.w700,
//                                             fontFamily: 'Gilroy'),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Obx(
//                                 () =>
//                                     homecontroller.categoriesData.value.data !=
//                                             null
//                                         ? all_categories_list()
//                                         : Container(),
//                               ),
//                               SizedBox(height: 10.h),

//                               Obx(
//                                 () => homecontroller
//                                             .studyPlanCourseNameDataModel
//                                             .data !=
//                                         null
//                                     ? all_cource_list()
//                                     : Container(),
//                               ),

//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     bottom: 10.h,
//                                     top: 10.h,
//                                     left: 8.w,
//                                     right: 8.w),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             FreeStudyMatrialViewScreen(),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     width: double.infinity.w,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       // boxShadow: [
//                                       //   BoxShadow(
//                                       //       color: const Color(0XFF503494)
//                                       //           .withOpacity(0.14),
//                                       //       offset: const Offset(-4, 5),
//                                       //       blurRadius: 16),
//                                       // ],
//                                       //  color: Colors.white,
//                                     ),
//                                     child: Container(
//                                       margin: EdgeInsets.all(15.w),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             mplanguage['freematerial']
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontFamily: 'Gilroy'),
//                                           ),
//                                           SizedBox(height: 5.w),
//                                           Text(
//                                             mplanguage['checkoutfree']
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 fontSize: 15.sp,
//                                                 fontFamily: 'Gilroy',
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Obx(
//                                             () => homecontroller
//                                                         .studyPlanCourseNameDataModel
//                                                         .data !=
//                                                     null
//                                                 ? all_free_cource_list()
//                                                 : Container(),
//                                           ),
//                                           SizedBox(height: 10.w),
//                                           Container(
//                                             width: double.infinity,
//                                             height: 50.h,
//                                             //color: Color(0XFF503494),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.h),
//                                               color: const Color(0XFF503494),
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 14.0, left: 15),
//                                               child: Text(
//                                                   mplanguage[
//                                                           'viewstudymaterial']
//                                                       .toString(),
//                                                   textAlign: TextAlign.left,
//                                                   style: TextStyle(
//                                                       color: Color(0XFFFFFFFF),
//                                                       fontSize: 18.sp,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       fontFamily: 'Gilroy')),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               // Padding(
//                               //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               //   child: Row(
//                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               //     children: [
//                               //       Text("Recently Added Course",
//                               //           style: TextStyle(
//                               //               fontSize: 18.sp,
//                               //               fontWeight: FontWeight.w700,
//                               //               fontFamily: 'Gilroy')),
//                               //       TextButton(
//                               //           onPressed: () {
//                               //             Get.to(const RecentlyAdded());
//                               //           },
//                               //           child: Text("See All",
//                               //               style: TextStyle(
//                               //                   fontFamily: 'Gilroy',
//                               //                   fontSize: 18.sp,
//                               //                   color: const Color(0XFF503494),
//                               //                   fontWeight: FontWeight.w700)))
//                               //     ],
//                               //   ),
//                               // ),
//                               // recent_added_list(),
//                               //SizedBox(height: 22.h),
//                               // Padding(
//                               //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               //   child: Text(
//                               //     mplanguage['testinomials'].toString(),
//                               //     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
//                               //   ),
//                               // ),
//                               // SizedBox(height: 15.h),
//                               // SizedBox(
//                               //   height: 150.h,
//                               //   child: TestimonialsWidget(),
//                               // ),
//                               SizedBox(height: 15.h),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (homecontroller.isloader.value)
//               SafeArea(
//                 top: false,
//                 bottom: false,
//                 child: ColoredBox(
//                   color: Colors.white.withOpacity(0.5),
//                   child: Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(.1),
//                             spreadRadius: 0.1,
//                             offset: const Offset(0.0, 0.0),
//                             blurRadius: 5.0,
//                           ),
//                         ],
//                       ),
//                       height: 80,
//                       width: 80,
//                       child: Platform.isIOS
//                           ? const CupertinoActivityIndicator(
//                               animating: true,
//                               color: Color(0XFF503494),
//                             )
//                           : const Padding(
//                               padding: EdgeInsets.all(25),
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 3.0,
//                                 color: Color(0XFF503494),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget generatepage() {
//     return CarouselSlider.builder(
//       options: CarouselOptions(
//         autoPlay: true,
//         enableInfiniteScroll: true,
//         initialPage: 0,
//         height: 200.0.h,
//         enlargeCenterPage: false,
//         viewportFraction: 1,
//         onPageChanged: (index, reason) {
//           homecontroller.onChange(index.obs);
//         },
//       ),
//       itemBuilder: (BuildContext context, int index, int realIndex) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: 200.h,
//             width: double.infinity,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: CachedNetworkImage(
//                 fit: BoxFit.fill,
//                 height: 200.h,
//                 // width: 49.93.w,
//                 imageUrl: homecontroller.homeDashboardDataModel.data?[0]
//                         .sliders?[index].image ??
//                     '',
//                 progressIndicatorBuilder: (context, url, downloadProgress) =>
//                     Center(
//                   child: Container(
//                     height: 30.h,
//                     width: 30.w,
//                     child: CircularProgressIndicator(
//                         value: downloadProgress.progress),
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => ClipRRect(
//                   borderRadius: BorderRadius.circular(10.h),
//                   child: Container(
//                     // height: 50.h,
//                     // width: 49.93.w,
//                     color: Colors.grey.withOpacity(0.2),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       itemCount:
//           homecontroller.homeDashboardDataModel.data?[0].sliders?.length ?? 0,
//     );
//   }

//   Widget indicator() {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(
//             homecontroller.homeDashboardDataModel.data?[0].sliders?.length ?? 0,
//             (index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 6.w),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               height: 10.h,
//               width: 10.w,
//               //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: (index == homecontroller.currentpage.value)
//                       ? const Color(0XFF503494)
//                       : const Color(0XFFDEDEDE)),
//             ),
//           );
//         }));
//   }

//   Widget design_list() {
//     return Expanded(
//       child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           shrinkWrap: true,
//           primary: false,
//           scrollDirection: Axis.horizontal,
//           itemCount: homecontroller
//                   .homeDashboardDataModel.data?[0].categories?.length ??
//               0,
//           itemBuilder: (BuildContext context, index) {
//             return Stack(
//               children: [
//                 Image(
//                   image: AssetImage('assets/d3.png'),
//                   height: 110.h,
//                   width: 110.h,
//                 )
//               ],
//             );
//           }),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   Widget horizontal_disidn() {
//     return (homecontroller
//                     .homeDashboardDataModel.data?.first.categories?.length ??
//                 0) >
//             0
//         ? Container(
//             //color: Colors.red,

//             height: 110.h,
//             width: double.infinity,
//             child: ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 shrinkWrap: true,
//                 primary: false,
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: homecontroller.homeDashboardDataModel.data?.first
//                         .categories?.length ??
//                     0,
//                 itemBuilder: (BuildContext context, index) {
//                   var item = homecontroller.homeDashboardDataModel.data?.first;
//                   return GestureDetector(
//                     onTap: () {
//                       Get.to(CategoryWiseProductScreen(
//                         categoryId:
//                             (item?.categories?[index].id ?? 0).toString(),
//                         categoryName: item?.categories?[index].title ?? '',
//                       ));
//                     },
//                     child: Container(
//                       height: 110.h,
//                       width: 110.w,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         //color: Colors.red,
//                         color: Colors.white,
//                       ),
//                       margin: EdgeInsets.only(right: 5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CachedNetworkImage(
//                             fit: BoxFit.fill,
//                             height: 50.h,
//                             width: 50.w,
//                             imageUrl:
//                                 '${ApiConstants.publicBaseUrl}/${item?.categories?[index].image?.originalImage ?? ''}',
//                             progressIndicatorBuilder:
//                                 (context, url, downloadProgress) => Center(
//                               child: Container(
//                                 height: 30.h,
//                                 width: 30.w,
//                                 child: CircularProgressIndicator(
//                                     value: downloadProgress.progress),
//                               ),
//                             ),
//                             errorWidget: (context, url, error) => ClipRRect(
//                               borderRadius: BorderRadius.circular(10.h),
//                               child: Container(
//                                 height: 50.h,
//                                 width: 50.w,
//                                 color: Colors.grey.withOpacity(0.2),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Text(
//                             item?.categories?[index].title ?? '',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Color(0XFF000000),
//                                 fontSize: 14.sp,
//                                 fontFamily: 'Gilroy',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         : SizedBox.shrink();
//   }

//   Widget trending_cource_list() {
//     return SizedBox(
//       //color: Colors.red,
//       height: 234.h,
//       width: double.infinity.w,
//       child: ListView.builder(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         physics: const BouncingScrollPhysics(),
//         primary: false,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount:
//             homecontroller.trendingCoursesDataModel.data?.courses?.length,
//         itemBuilder: (BuildContext context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 4.w),
//             child: GestureDetector(
//               onTap: () {
//                 Get.to(MyCources(),
//                     arguments: homecontroller.trendingCoursesDataModel.data
//                             ?.courses?[index].id ??
//                         0);
//               },
//               child: Container(
//                 width: 177.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 177.h,
//                       width: 177.w,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: CachedNetworkImage(
//                           fit: BoxFit.fill,
//                           // height: 50.h,
//                           // width: 50.w,
//                           imageUrl:
//                               '${ApiConstants.publicBaseUrl}/${homecontroller.trendingCoursesDataModel.data?.courses?[index].courseThumbnail ?? ''}',
//                           progressIndicatorBuilder:
//                               (context, url, downloadProgress) => Center(
//                             child: Container(
//                               height: 30.h,
//                               width: 30.w,
//                               child: CircularProgressIndicator(
//                                   value: downloadProgress.progress),
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => ClipRRect(
//                             borderRadius: BorderRadius.circular(10.h),
//                             child: Container(
//                               // height: 50.h,
//                               // width: 50.w,
//                               color: Colors.grey.withOpacity(0.2),
//                             ),
//                           ),
//                         ),
//                       ),
//                       //alignment: Alignment.topLeft,
//                       // child:
//                       // Padding(
//                       //   padding: EdgeInsets.only(
//                       //       left: 10.w, right: 147.w, bottom: 142.h),
//                       //   child: Container(
//                       //     height: 20.h,
//                       //     width: 20.w,
//                       //     decoration: const BoxDecoration(
//                       //         shape: BoxShape.circle, color: Colors.white),
//                       //     child: Center(
//                       //       child: GestureDetector(
//                       //         onTap: () {
//                       //           // toggle(index);
//                       //         },
//                       //         child: trendingCource[index].buttonStatus == true
//                       //             ? Image(
//                       //                 image:
//                       //                     AssetImage("assets/saveboldblue.png"),
//                       //                 height: 10.h,
//                       //                 width: 9.w,
//                       //               )
//                       //             : Image(
//                       //                 image: AssetImage("assets/savebold.png"),
//                       //                 height: 10.h,
//                       //                 width: 9.w,
//                       //               ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Expanded(
//                       child: Text(
//                         homecontroller.trendingCoursesDataModel.data
//                                 ?.courses?[index].title ??
//                             '',
//                         maxLines: 2,
//                         style: TextStyle(
//                           fontFamily: 'Gilroy',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 15.sp,
//                           color: const Color(0XFF000000),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     // Text(trendingCource[index].subtitle!,
//                     //     style: TextStyle(
//                     //         fontFamily: 'Gilroy',
//                     //         fontWeight: FontWeight.w700,
//                     //         fontSize: 15.sp,
//                     //         color: const Color(0XFF000000))),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget all_cource_list() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//           child: Text(mplanguage['courses'].toString(),
//               style: TextStyle(
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'Gilroy')),
//         ),
//         SizedBox(
//           //color: Colors.red,
//           height: 234.h,
//           width: double.infinity.w,
//           child: ListView.builder(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             physics: const BouncingScrollPhysics(),
//             primary: false,
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount:
//                 homecontroller.trendingCoursesDataModel.data?.courses?.length,
//             itemBuilder: (BuildContext context, index) {
//               var course =
//                   homecontroller.trendingCoursesDataModel.data?.courses;

//               // var courseList = homecontroller.categotry.title;

//               if ((course?[index].is_show ?? 1) == 0) {
//                 return SizedBox.shrink();
//               }
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4.w),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.to(MyCources(), arguments: course?[index].id ?? 0);
//                   },
//                   child: Container(
//                     width: 250.w,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 177.h,
//                           width: 250.w,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: CachedNetworkImage(
//                               fit: BoxFit.fill,
//                               // height: 50.h,
//                               // width: 50.w,
//                               imageUrl:
//                                   '${ApiConstants.publicBaseUrl}/${course?[index].courseThumbnail ?? ''}',
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) => Center(
//                                 child: Container(
//                                   height: 30.h,
//                                   width: 30.w,
//                                   child: CircularProgressIndicator(
//                                       value: downloadProgress.progress),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) => ClipRRect(
//                                 borderRadius: BorderRadius.circular(10.h),
//                                 child: Container(
//                                   // height: 50.h,
//                                   // width: 50.w,
//                                   color: Colors.grey.withOpacity(0.2),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           //alignment: Alignment.topLeft,
//                           // child:
//                           // Padding(
//                           //   padding: EdgeInsets.only(
//                           //       left: 10.w, right: 147.w, bottom: 142.h),
//                           //   child: Container(
//                           //     height: 20.h,
//                           //     width: 20.w,
//                           //     decoration: const BoxDecoration(
//                           //         shape: BoxShape.circle, color: Colors.white),
//                           //     child: Center(
//                           //       child: GestureDetector(
//                           //         onTap: () {
//                           //           // toggle(index);
//                           //         },
//                           //         child: trendingCource[index].buttonStatus == true
//                           //             ? Image(
//                           //                 image:
//                           //                     AssetImage("assets/saveboldblue.png"),
//                           //                 height: 10.h,
//                           //                 width: 9.w,
//                           //               )
//                           //             : Image(
//                           //                 image: AssetImage("assets/savebold.png"),
//                           //                 height: 10.h,
//                           //                 width: 9.w,
//                           //               ),
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                         ),
//                         SizedBox(height: 8.h),
//                         Expanded(
//                           child: Text(
//                             homecontroller.categotry.title ?? '',
//                             maxLines: 5,
//                             style: TextStyle(
//                               fontFamily: 'Gilroy',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 15.sp,
//                               color: const Color(0XFF000000),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         // Text(trendingCource[index].subtitle!,
//                         //     style: TextStyle(
//                         //         fontFamily: 'Gilroy',
//                         //         fontWeight: FontWeight.w700,
//                         //         fontSize: 15.sp,
//                         //         color: const Color(0XFF000000))),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget all_free_cource_list() {
//     return SizedBox(
//       //color: Colors.red,
//       height: 234.h,
//       width: double.infinity.w,
//       child: ListView.builder(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         physics: const BouncingScrollPhysics(),
//         primary: false,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: homecontroller.freeCourseDataModel.data?.courses?.length,
//         itemBuilder: (BuildContext context, index) {
//           var course = homecontroller.freeCourseDataModel.data?.courses;
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 4.w),
//             child: GestureDetector(
//               onTap: () {
//                 Get.to(MyCources(), arguments: course?[index].id ?? 0);
//               },
//               child: Container(
//                 width: 250.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 177.h,
//                       width: 250.w,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: CachedNetworkImage(
//                           fit: BoxFit.fill,
//                           // height: 50.h,
//                           // width: 50.w,
//                           imageUrl:
//                               '${ApiConstants.publicBaseUrl}/${course?[index].courseThumbnail ?? ''}',
//                           progressIndicatorBuilder:
//                               (context, url, downloadProgress) => Center(
//                             child: Container(
//                               height: 30.h,
//                               width: 30.w,
//                               child: CircularProgressIndicator(
//                                   value: downloadProgress.progress),
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => ClipRRect(
//                             borderRadius: BorderRadius.circular(10.h),
//                             child: Container(
//                               // height: 50.h,
//                               // width: 50.w,
//                               color: Colors.grey.withOpacity(0.2),
//                             ),
//                           ),
//                         ),
//                       ),
//                       //alignment: Alignment.topLeft,
//                       // child:
//                       // Padding(
//                       //   padding: EdgeInsets.only(
//                       //       left: 10.w, right: 147.w, bottom: 142.h),
//                       //   child: Container(
//                       //     height: 20.h,
//                       //     width: 20.w,
//                       //     decoration: const BoxDecoration(
//                       //         shape: BoxShape.circle, color: Colors.white),
//                       //     child: Center(
//                       //       child: GestureDetector(
//                       //         onTap: () {
//                       //           // toggle(index);
//                       //         },
//                       //         child: trendingCource[index].buttonStatus == true
//                       //             ? Image(
//                       //                 image:
//                       //                     AssetImage("assets/saveboldblue.png"),
//                       //                 height: 10.h,
//                       //                 width: 9.w,
//                       //               )
//                       //             : Image(
//                       //                 image: AssetImage("assets/savebold.png"),
//                       //                 height: 10.h,
//                       //                 width: 9.w,
//                       //               ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Expanded(
//                       child: Text(
//                         course?[index].title ?? '',
//                         maxLines: 2,
//                         style: TextStyle(
//                           fontFamily: 'Gilroy',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 15.sp,
//                           color: const Color(0XFF000000),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     // Text(trendingCource[index].subtitle!,
//                     //     style: TextStyle(
//                     //         fontFamily: 'Gilroy',
//                     //         fontWeight: FontWeight.w700,
//                     //         fontSize: 15.sp,
//                     //         color: const Color(0XFF000000))),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget all_categories_list() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: SizedBox(
//         width: double.infinity.w,
//         child: Wrap(
//           spacing: 8.0,
//           runSpacing: 4.0,
//           children: homecontroller.categoriesData.value.data!.categories!
//               .take(5)
//               .map((category) {
//             return GestureDetector(
//               onTap: () {
//                 Get.to(SubCategoriesScreen(
//                   category: category,
//                 ));
//               },
//               child: Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                     color: WidgetStateColor.transparent,
//                     border: Border.all(color: Colors.black)),
//                 child: Text(
//                   category.title.toString(),
//                   style: TextStyle(
//                       fontFamily: 'Gilroy',
//                       color: const Color(0XFF000000),
//                       fontSize: 15.sp,
//                       overflow: TextOverflow.ellipsis,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   Widget recent_added_list() {
//     return Container(
//       color: const Color(0XFFFFFFFF),
//       height: 323.h,
//       width: double.infinity.w,
//       child: ListView.builder(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           physics: const BouncingScrollPhysics(),
//           primary: false,
//           shrinkWrap: true,
//           itemCount: recentAdded.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (BuildContext context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Get.to(RecentCourceDetail(
//                   corcedetail: recentAdded[index],
//                 ));
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4.w),
//                 child: Container(
//                   //height: 323,
//                   width: 276.w,

//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                             color: const Color(0XFF503494).withOpacity(0.14),
//                             offset: const Offset(-4, 5),
//                             blurRadius: 16),
//                       ],
//                       color: Colors.white),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 158.h,
//                         width: 276.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           image: DecorationImage(
//                               image: AssetImage(
//                                 recentAdded[index].image!,
//                               ),
//                               fit: BoxFit.cover),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               right: 230.w, bottom: 120.h, top: 10.h),
//                           child: Container(
//                               height: 20.h,
//                               width: 20.w,
//                               decoration: const BoxDecoration(
//                                   shape: BoxShape.circle, color: Colors.white),
//                               child: IconButton(
//                                   splashRadius: 10,
//                                   onPressed: () {
//                                     toggleRecent(index);
//                                   },
//                                   icon: Center(
//                                     child:
//                                         recentAdded[index].buttonStatus == true
//                                             ? Image(
//                                                 image: AssetImage(
//                                                     "assets/saveboldblue.png"),
//                                                 height: 10.h,
//                                                 width: 9.w,
//                                               )
//                                             : Image(
//                                                 image: AssetImage(
//                                                     "assets/savebold.png"),
//                                                 height: 10.h,
//                                                 width: 9.w,
//                                               ),
//                                   ))),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(left: 10.w, top: 10.h),
//                             child: Container(
//                               height: 25.h,
//                               width: 58.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: const Color(0XFFFAF4E1),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Image(
//                                     image:
//                                         const AssetImage("assets/staricon.png"),
//                                     height: 17.h,
//                                     width: 17.w,
//                                   ),
//                                   Text(
//                                     recentAdded[index].review!,
//                                     style: TextStyle(
//                                         fontFamily: 'Gilroy',
//                                         color: const Color(0XFFFFC403),
//                                         fontSize: 15.sp),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: 5.w),
//                             child: Row(
//                               children: [
//                                 Image(
//                                   image: const AssetImage("assets/clock.png"),
//                                   height: 17.h,
//                                   width: 17.w,
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Text(
//                                   recentAdded[index].time!,
//                                   style: TextStyle(
//                                       fontSize: 15.sp,
//                                       color: Color(0XFF000000),
//                                       fontFamily: 'Gilroy'),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 11.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                         child: Text(
//                           recentAdded[index].title!,
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 15.sp,
//                               color: Color(0XFF000000),
//                               fontFamily: 'Gilroy'),
//                         ),
//                       ),
//                       SizedBox(height: 11.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Image(
//                                   image: AssetImage(
//                                       recentAdded[index].circleimage!),
//                                   height: 40.h,
//                                   width: 40.w,
//                                 ),
//                                 SizedBox(width: 10.w),
//                                 Text(
//                                   recentAdded[index].personname!,
//                                   style: TextStyle(
//                                       fontFamily: 'Gilroy',
//                                       fontWeight: FontWeight.w400,
//                                       color: Color(0XFF503494),
//                                       fontSize: 15.sp),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               height: 33.h,
//                               width: 76.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: const Color(0XFFE5ECFF),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 recentAdded[index].price!,
//                                 style: TextStyle(
//                                     color: const Color(0XFF503494),
//                                     fontFamily: 'Gilroy',
//                                     fontSize: 19.sp,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/add_btach_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_description_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_mcq_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/lesson_details_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/study_plan_assigment_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/controllers/lesson_details_controller.dart';
import 'package:edxera/category/category_view.dart';
import 'package:edxera/course_list/course_list_controller.dart';
import 'package:edxera/home/all_categories_screen.dart';
import 'package:edxera/home/categorey_wise_subject_screen.dart';
import 'package:edxera/home/free_study_matrial_view_screen.dart';
import 'package:edxera/home/notification_screen.dart';
import 'package:edxera/home/sub_categories_screen.dart';
import 'package:edxera/home/testimonials_widget.dart';
import 'package:edxera/profile/edit_screen.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/cources/cources.dart';
import 'package:edxera/home/recent_added_cource_detail.dart';
import 'package:edxera/home/trending_cource.dart';
import 'package:edxera/models/recently_added.dart';
import 'package:edxera/models/trending_cource.dart';
import 'package:edxera/utils/slider_page_data_model.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../login/login_empty_state.dart';
import '../repositories/api/api_constants.dart';
import '../repositories/post_repository.dart';
import '../utils/screen_size.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<Trending> trendingCource = Utils.getTrending();
  List<Recent> recentAdded = Utils.getRecentAdded();
  HomeController homecontroller = Get.put(HomeController());
  final CourseController courseController = Get.put(CourseController());
  LessonDetailsController lessonDetailsController =
      Get.put(LessonDetailsController());

  // int currentpage = 0;
  PageController controller = PageController();
  bool buttonvalue = false;
  int currentvalue = 0;
  List userDetail = Utils.getUser();
  Map<String, dynamic> mplanguage = new HashMap();

  Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 500));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      homecontroller.userDataApi();
      homecontroller.notificationCountDataApi();
      homecontroller.homeDashboardDatGetApi();
      homecontroller.homeCategoryDataGetApi();
      homecontroller.getFreeCourses();
      homecontroller.homeDashboardTrendingDatGetApi();
      homecontroller.homeDashboardTestimonailasDatGetApi();
      homecontroller.homeDashboardStudyPlansDatGetApi();
    });

    super.initState();
    checkLanguage();
  }

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  toggle(int index) {
    setState(() {
      if (trendingCource[index].buttonStatus == true) {
        trendingCource[index].buttonStatus = false;
      } else {
        trendingCource[index].buttonStatus = true;
      }
    });
  }

  toggleRecent(int index) {
    setState(() {
      if (recentAdded[index].buttonStatus == true) {
        recentAdded[index].buttonStatus = false;
      } else {
        recentAdded[index].buttonStatus = true;
      }
    });
  }

  void showMySelectedCategory() {
    homecontroller.fetchUserCategories();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 350, // Increased height to accommodate button
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<HomeController>(
                  autoRemove: false,
                  builder: (controller) {
                    if (controller.ishUserCategories.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final list = controller.userCategory.value.data ?? [];

                      return ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = list[index];
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Text(item.title ?? ""),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the modal first
                  Get.to(
                      CategoryGridView()); // Navigate to category selection page
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: Text("Add More Categories"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56), // Set a fixed height for the AppBar
        child: AppBar(
          backgroundColor: Colors.white,
          title: isSearching
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    onChanged: (value) {
                      _debouncer.call(
                        () {
                          homecontroller.homeDashboardTrendingDatGetApi(
                              search: value);
                        },
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(
                        color: Colors.black), // Set text color to black
                  ),
                )
              : Row(
                  children: [
                    Image.asset(
                      'assets/app_logo.jpeg', // Your logo image
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edxera",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900),
                    ),
                  ],
                ),
          actions: [
            isSearching
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      homecontroller.homeDashboardTrendingDatGetApi();
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                  ),
          ],
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            SafeArea(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) => SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Divider(),
                        Expanded(
                          child: ListView(
                            // physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            primary: true,
                            children: [
                              Obx(
                                () => homecontroller
                                            .homeDashboardDataModel.data !=
                                        null
                                    ? generatepage()
                                    : Container(),
                              ),
                              // SizedBox(height: 20.h),
                              indicator(),
                              SizedBox(height: 20.h),
                              Column(
                                children: [
                                  if (homecontroller.countries.isEmpty)
                                    ...[]
                                  else ...[
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0XFF503494)
                                                  .withOpacity(0.14),
                                              offset: const Offset(-4, 5),
                                              blurRadius: 16),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/lesson1.png',
                                                  height: 66.h,
                                                  width: 66.w,
                                                ),
                                                SizedBox(
                                                  width: 10.h,
                                                ),
                                                Expanded(
                                                  child: (homecontroller
                                                                  .countries !=
                                                              [] ||
                                                          homecontroller
                                                              .countries
                                                              .isNotEmpty)
                                                      ? Theme(
                                                          data: ThemeData(
                                                            textTheme: TextTheme(
                                                                titleMedium: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontFamily:
                                                                        'Gilroy',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                          child: DropdownSearch<
                                                              String>(
                                                            popupProps:
                                                                PopupProps.menu(
                                                              showSearchBox:
                                                                  true,
                                                              showSelectedItems:
                                                                  true,
                                                              disabledItemFn:
                                                                  (String s) =>
                                                                      s.startsWith(
                                                                          'I'),
                                                            ),
                                                            items:
                                                                homecontroller
                                                                    .countries,
                                                            dropdownDecoratorProps:
                                                                DropDownDecoratorProps(
                                                              baseStyle: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              dropdownSearchDecoration:
                                                                  InputDecoration(
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0XFF9B9B9B),
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontFamily:
                                                                        'Gilroy',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                                focusedBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              homecontroller
                                                                      .dropdownvalue
                                                                      .value =
                                                                  value ?? '';
                                                              for (var element
                                                                  in homecontroller
                                                                          .studyPlanCourseNameDataModel
                                                                          .data
                                                                          ?.userCourses ??
                                                                      []) {
                                                                if (element
                                                                        .courseTitle ==
                                                                    value) {
                                                                  homecontroller
                                                                          .batchid
                                                                          .value =
                                                                      element
                                                                          .batchId
                                                                          .toString();
                                                                  print(element
                                                                      .batchId);
                                                                  PrefData.setCourseID(
                                                                      element
                                                                          .batchId
                                                                          .toString());
                                                                  PrefData.setCourseName(
                                                                      value ??
                                                                          '');
                                                                  homecontroller
                                                                      .getTodayStudyPlan(element
                                                                          .batchId
                                                                          .toString())
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                }
                                                              }
                                                            },
                                                            onSaved:
                                                                (newValue) {},
                                                            selectedItem:
                                                                homecontroller
                                                                    .dropdownvalue
                                                                    .value,
                                                          ),
                                                        )
                                                      : Container(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Obx(
                                              () => Text(
                                                homecontroller
                                                    .dropdownvalue.value,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20.sp,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  SizedBox(height: 20.h),
                                  if ((homecontroller.todaysStudyPlanDataModel
                                              .data?.studyPlans?.length ??
                                          0) >
                                      0) ...[
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0XFF503494)
                                                  .withOpacity(0.14),
                                              offset: const Offset(-4, 5),
                                              blurRadius: 16),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if ((homecontroller
                                                        .todaysStudyPlanDataModel
                                                        .data
                                                        ?.studyPlans
                                                        ?.length ??
                                                    0) >
                                                0)
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                            if ((homecontroller
                                                        .todaysStudyPlanDataModel
                                                        .data
                                                        ?.studyPlans
                                                        ?.length ??
                                                    0) >
                                                0)
                                              homecontroller
                                                          .todaysStudyPlanDataModel
                                                          .data
                                                          ?.studyPlans !=
                                                      null
                                                  ? Obx(() => ListView.builder(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        itemCount: homecontroller
                                                            .todaysStudyPlanDataModel
                                                            .data
                                                            ?.studyPlans?[0]
                                                            .items
                                                            ?.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, indexs) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              if ((homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .type ??
                                                                      '') ==
                                                                  'EXAM_MCQ') {
                                                                Get.to(
                                                                    ExamMcqScreen(
                                                                  examPogress: homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .progressStatus ??
                                                                      '',
                                                                  title: homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .title ??
                                                                      '',
                                                                  examid: (homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .examId ??
                                                                          0)
                                                                      .toString(),
                                                                  studyPlanId: (homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .fkIntStudyPlanItemsId ??
                                                                          0)
                                                                      .toString(),
                                                                ));
                                                              } else if ((homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .type ??
                                                                      '') ==
                                                                  'EXAM_DESCRIPTION') {
                                                                Get.to(
                                                                    ExamDescriptionScreen(
                                                                  examPogress: homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .progressStatus ??
                                                                      '',
                                                                  title: homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .title ??
                                                                      '',
                                                                  examid: (homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .examId ??
                                                                          0)
                                                                      .toString(),
                                                                  studyPlanId: (homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .fkIntStudyPlanItemsId ??
                                                                          0)
                                                                      .toString(),
                                                                ));
                                                              } else if ((homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .type ??
                                                                      '') ==
                                                                  'ASSIGMENT') {
                                                                Get.to(
                                                                    StudyPlanAssigmentScreen(
                                                                  title: homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .title ??
                                                                      '',
                                                                  assigmentid: (homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .assigmentId ??
                                                                          0)
                                                                      .toString(),
                                                                  studyPlanId: (homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .fkIntStudyPlanItemsId ??
                                                                          0)
                                                                      .toString(),
                                                                ));
                                                              } else if ((homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .type ??
                                                                      '') ==
                                                                  'DIRECT_VIDEO') {
                                                                if ((homecontroller
                                                                            .todaysStudyPlanDataModel
                                                                            .data
                                                                            ?.studyPlans?[0]
                                                                            .items?[indexs]
                                                                            .dvVideoFile ??
                                                                        '') !=
                                                                    '') {
                                                                  var dataVIdeo = jsonDecode(homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .dvVideoFile ??
                                                                      '');
                                                                  print(dataVIdeo[
                                                                      "video"]);

                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          VidioPlay(
                                                                              lessonplay: '${ApiConstants.publicBaseUrl}/${dataVIdeo["video"]}'),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  Get.to(() => YoutubeVideoPlayerScreen(
                                                                      url: homecontroller
                                                                              .todaysStudyPlanDataModel
                                                                              .data
                                                                              ?.studyPlans?[0]
                                                                              .items?[indexs]
                                                                              .dvYoutubeLink ??
                                                                          ''));
                                                                }
                                                              } else if ((homecontroller
                                                                          .todaysStudyPlanDataModel
                                                                          .data
                                                                          ?.studyPlans?[
                                                                              0]
                                                                          .items?[
                                                                              indexs]
                                                                          .type ??
                                                                      '') ==
                                                                  'CHAPTER') {
                                                                homecontroller.chepterInnerApiCall(
                                                                    (homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].chapterId ??
                                                                            0)
                                                                        .toString(),
                                                                    (homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].pkIntStudyPlanItemsId ??
                                                                            '')
                                                                        .toString());
                                                              }
                                                            },
                                                            child: (homecontroller
                                                                            .todaysStudyPlanDataModel
                                                                            .data
                                                                            ?.studyPlans?[0]
                                                                            .items?[indexs]
                                                                            .type ??
                                                                        '') ==
                                                                    'CHAPTER'
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                    child:
                                                                        ListTile(
                                                                      leading:
                                                                          Container(
                                                                        height:
                                                                            60.h,
                                                                        width:
                                                                            60.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.grey[200],
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              width: double.infinity,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                                                              height: 20.h,
                                                                              child: Text(
                                                                                mplanguage['day'].toString(),
                                                                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].studyPlansDate?.split('-').last ?? '',
                                                                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].title ??
                                                                            '',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize: 20.sp,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            20),
                                                                    child:
                                                                        ListTile(
                                                                      leading:
                                                                          Container(
                                                                        height:
                                                                            60.h,
                                                                        width:
                                                                            60.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .blue
                                                                              .withOpacity(0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .play_circle,
                                                                          color:
                                                                              Colors.blue,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].title ??
                                                                            '',
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: 15.sp,
                                                                            color: Colors.black),
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        mplanguage['progress'].toString() +
                                                                            ':${homecontroller.todaysStudyPlanDataModel.data?.studyPlans?[0].items?[indexs].progressStatus ?? ''}',
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontSize: 14.sp,
                                                                            color: Colors.grey),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          );
                                                        },
                                                      ))
                                                  : Container(
                                                      child: Center(
                                                        child: Text(
                                                          mplanguage['nodata']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                  if (!homecontroller.isStudyPlan.value)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LessonDetailsScreens(
                                              batchId:
                                                  homecontroller.batchid.value,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.h / 2),
                                          color: const Color(0XFF503494),
                                        ),
                                        height: 50.h,
                                        margin: EdgeInsets.only(
                                            left: 30.w, right: 30.w),
                                        child: Text(
                                          mplanguage['viewstudyplan']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(
                                () => homecontroller
                                            .homeDashboardDataModel.data !=
                                        null
                                    ? horizontal_disidn()
                                    : Container(),
                              ),
                              SizedBox(height: 30.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                    mplanguage["batchsuccessfull"].toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Gilroy')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 20.h,
                                    top: 15.h,
                                    left: 8.w,
                                    right: 8.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddBatchViewScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/batchImages.jpg'),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0XFF503494)
                                                  .withOpacity(0.14),
                                              offset: const Offset(-4, 5),
                                              blurRadius: 16),
                                        ],
                                        color: Colors.white),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      margin: EdgeInsets.all(15.w),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10.w),
                                            Text(
                                              mplanguage['reqtutor'].toString(),
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10.w),
                                            Container(
                                              height: 40.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.8,
                                              //color: Color(0XFF503494),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.h),
                                                color: const Color(0XFF503494),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    mplanguage["sendjoin"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0XFFFFFFFF),
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Gilroy')),
                                              ),
                                            ),
                                            SizedBox(height: 10.w),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Learning that fits",
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Gilroy')),
                                    Text("Skills for your present (and future)",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Gilroy')),
                                    SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        showMySelectedCategory();
                                      },
                                      child: Text("Show My Selected Category"),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 20.w, vertical: 10.h),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Categories",
                              //         style: TextStyle(
                              //             fontSize: 13.sp,
                              //             fontWeight: FontWeight.w700,
                              //             fontFamily: 'Gilroy'),
                              //       ),
                              //       GestureDetector(
                              //         onTap: () {
                              //           Get.to(
                              //             AllCategoriesScreen(),
                              //           );
                              //         },
                              //         child: Text(
                              //           "See all",
                              //           style: TextStyle(
                              //               fontSize: 13.sp,
                              //               fontWeight: FontWeight.w700,
                              //               fontFamily: 'Gilroy'),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Obx(
                              //   () =>
                              //       homecontroller.categoriesData.value.data !=
                              //               null
                              //           ? all_categories_list()
                              //           : Container(),
                              // ),
                              // SizedBox(height: 10.h),

                              Obx(
                                () => homecontroller
                                            .studyPlanCourseNameDataModel
                                            .data !=
                                        null
                                    ? all_cource_list()
                                    : Container(),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10.h,
                                    top: 10.h,
                                    left: 8.w,
                                    right: 8.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FreeStudyMatrialViewScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: const Color(0XFF503494)
                                      //           .withOpacity(0.14),
                                      //       offset: const Offset(-4, 5),
                                      //       blurRadius: 16),
                                      // ],
                                      //  color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(15.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mplanguage['freematerial']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          SizedBox(height: 5.w),
                                          Text(
                                            mplanguage['checkoutfree']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Obx(
                                            () => homecontroller
                                                        .studyPlanCourseNameDataModel
                                                        .data !=
                                                    null
                                                ? all_free_cource_list()
                                                : Container(),
                                          ),
                                          SizedBox(height: 10.w),
                                          Container(
                                            width: double.infinity,
                                            height: 50.h,
                                            //color: Color(0XFF503494),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.h),
                                              color: const Color(0XFF503494),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14.0, left: 15),
                                              child: Text(
                                                  mplanguage[
                                                          'viewstudymaterial']
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color(0XFFFFFFFF),
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gilroy')),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text("Recently Added Course",
                              //           style: TextStyle(
                              //               fontSize: 18.sp,
                              //               fontWeight: FontWeight.w700,
                              //               fontFamily: 'Gilroy')),
                              //       TextButton(
                              //           onPressed: () {
                              //             Get.to(const RecentlyAdded());
                              //           },
                              //           child: Text("See All",
                              //               style: TextStyle(
                              //                   fontFamily: 'Gilroy',
                              //                   fontSize: 18.sp,
                              //                   color: const Color(0XFF503494),
                              //                   fontWeight: FontWeight.w700)))
                              //     ],
                              //   ),
                              // ),
                              // recent_added_list(),
                              //SizedBox(height: 22.h),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                              //   child: Text(
                              //     mplanguage['testinomials'].toString(),
                              //     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
                              //   ),
                              // ),
                              // SizedBox(height: 15.h),
                              // SizedBox(
                              //   height: 150.h,
                              //   child: TestimonialsWidget(),
                              // ),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (homecontroller.isloader.value)
              SafeArea(
                top: false,
                bottom: false,
                child: ColoredBox(
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            spreadRadius: 0.1,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      height: 80,
                      width: 80,
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator(
                              animating: true,
                              color: Color(0XFF503494),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(25),
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                color: Color(0XFF503494),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget generatepage() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: true,
        initialPage: 0,
        height: 200.0.h,
        enlargeCenterPage: false,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          homecontroller.onChange(index.obs);
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                height: 200.h,
                // width: 49.93.w,
                imageUrl: homecontroller.homeDashboardDataModel.data?[0]
                        .sliders?[index].image ??
                    '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.h),
                  child: Container(
                    // height: 50.h,
                    // width: 49.93.w,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount:
          homecontroller.homeDashboardDataModel.data?[0].sliders?.length ?? 0,
    );
  }

  Widget indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            homecontroller.homeDashboardDataModel.data?[0].sliders?.length ?? 0,
            (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 10.h,
              width: 10.w,
              //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == homecontroller.currentpage.value)
                      ? const Color(0XFF503494)
                      : const Color(0XFFDEDEDE)),
            ),
          );
        }));
  }

  Widget design_list() {
    return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemCount: homecontroller
                  .homeDashboardDataModel.data?[0].categories?.length ??
              0,
          itemBuilder: (BuildContext context, index) {
            return Stack(
              children: [
                Image(
                  image: AssetImage('assets/d3.png'),
                  height: 110.h,
                  width: 110.h,
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget horizontal_disidn() {
    return (homecontroller
                    .homeDashboardDataModel.data?.first.categories?.length ??
                0) >
            0
        ? Container(
            //color: Colors.red,

            height: 110.h,
            width: double.infinity,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: homecontroller.homeDashboardDataModel.data?.first
                        .categories?.length ??
                    0,
                itemBuilder: (BuildContext context, index) {
                  var item = homecontroller.homeDashboardDataModel.data?.first;
                  return GestureDetector(
                    onTap: () {
                      Get.to(CategoryWiseProductScreen(
                        categoryId:
                            (item?.categories?[index].id ?? 0).toString(),
                        categoryName: item?.categories?[index].title ?? '',
                      ));
                    },
                    child: Container(
                      height: 110.h,
                      width: 110.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.red,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 50.h,
                            width: 50.w,
                            imageUrl:
                                '${ApiConstants.publicBaseUrl}/${item?.categories?[index].image?.originalImage ?? ''}',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: Container(
                                height: 30.h,
                                width: 30.w,
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(10.h),
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            item?.categories?[index].title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0XFF000000),
                                fontSize: 14.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : SizedBox.shrink();
  }

  Widget trending_cource_list() {
    return SizedBox(
      //color: Colors.red,
      height: 234.h,
      width: double.infinity.w,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: homecontroller.trendingCoursesDataModel.data?.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () {
                Get.to(MyCources(),
                    arguments: homecontroller
                            .trendingCoursesDataModel.data?[index].id ??
                        0);
              },
              child: Container(
                width: 177.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 177.h,
                      width: 177.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          // height: 50.h,
                          // width: 50.w,
                          imageUrl:
                              '${ApiConstants.publicBaseUrl}/${homecontroller.trendingCoursesDataModel.data?[index].courseThumbnail ?? ''}',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.h),
                            child: Container(
                              // height: 50.h,
                              // width: 50.w,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      //alignment: Alignment.topLeft,
                      // child:
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       left: 10.w, right: 147.w, bottom: 142.h),
                      //   child: Container(
                      //     height: 20.h,
                      //     width: 20.w,
                      //     decoration: const BoxDecoration(
                      //         shape: BoxShape.circle, color: Colors.white),
                      //     child: Center(
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           // toggle(index);
                      //         },
                      //         child: trendingCource[index].buttonStatus == true
                      //             ? Image(
                      //                 image:
                      //                     AssetImage("assets/saveboldblue.png"),
                      //                 height: 10.h,
                      //                 width: 9.w,
                      //               )
                      //             : Image(
                      //                 image: AssetImage("assets/savebold.png"),
                      //                 height: 10.h,
                      //                 width: 9.w,
                      //               ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Text(
                        homecontroller
                                .trendingCoursesDataModel.data?[index].title ??
                            '',
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: const Color(0XFF000000),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // Text(trendingCource[index].subtitle!,
                    //     style: TextStyle(
                    //         fontFamily: 'Gilroy',
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 15.sp,
                    //         color: const Color(0XFF000000))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget all_cource_list() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Text(mplanguage['courses'].toString(),
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy')),
        ),
        SizedBox(
          //color: Colors.red,
          height: 234.h,
          width: double.infinity.w,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const BouncingScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homecontroller.trendingCoursesDataModel.data?.length,
            itemBuilder: (BuildContext context, index) {
              var course = homecontroller.trendingCoursesDataModel.data;

              // if ((course?[index].is_show ?? 1) == 0) {
              //   return SizedBox.shrink();
              // }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: GestureDetector(
                  onTap: () {
                    Get.to(MyCources(), arguments: course?[index].id ?? 0);
                  },
                  child: Container(
                    width: 250.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 177.h,
                          width: 250.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              // height: 50.h,
                              // width: 50.w,
                              imageUrl:
                                  '${ApiConstants.publicBaseUrl}/${course?[index].courseThumbnail ?? ''}',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                              ),
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(10.h),
                                child: Container(
                                  // height: 50.h,
                                  // width: 50.w,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          //alignment: Alignment.topLeft,
                          // child:
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: 10.w, right: 147.w, bottom: 142.h),
                          //   child: Container(
                          //     height: 20.h,
                          //     width: 20.w,
                          //     decoration: const BoxDecoration(
                          //         shape: BoxShape.circle, color: Colors.white),
                          //     child: Center(
                          //       child: GestureDetector(
                          //         onTap: () {
                          //           // toggle(index);
                          //         },
                          //         child: trendingCource[index].buttonStatus == true
                          //             ? Image(
                          //                 image:
                          //                     AssetImage("assets/saveboldblue.png"),
                          //                 height: 10.h,
                          //                 width: 9.w,
                          //               )
                          //             : Image(
                          //                 image: AssetImage("assets/savebold.png"),
                          //                 height: 10.h,
                          //                 width: 9.w,
                          //               ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: Text(
                            course?[index].title ?? '',
                            maxLines: 5,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: const Color(0XFF000000),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        // Text(trendingCource[index].subtitle!,
                        //     style: TextStyle(
                        //         fontFamily: 'Gilroy',
                        //         fontWeight: FontWeight.w700,
                        //         fontSize: 15.sp,
                        //         color: const Color(0XFF000000))),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget all_cource_list() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  //         child: Text(mplanguage['courses'].toString(),
  //             style: TextStyle(
  //                 fontSize: 13.sp,
  //                 fontWeight: FontWeight.w700,
  //                 fontFamily: 'Gilroy')),
  //       ),
  //       SizedBox(
  //           //color: Colors.red,
  //           height: 234.h,
  //           width: double.infinity.w,
  //           child: ListView.builder(
  //             itemCount: courseController.courseList.length,
  //             itemBuilder: (context, index) {
  //               final course = courseController.courseList[index];
  //               return Card(
  //                 color: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12)),
  //                 margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                 child: ListTile(
  //                   title: Text(course.title ?? 'No Name',
  //                       style: TextStyle(color: Colors.blue)),
  //                   subtitle: Text(
  //                       course.shortDescription ?? 'No description available',
  //                       style: TextStyle(color: Colors.grey[700])),
  //                   leading: Icon(Icons.book, color: Colors.blue),
  //                   onTap: () {
  //                     // Navigate to course details if needed
  //                   },
  //                 ),
  //               );
  //             },
  //           )),
  //     ],
  //   );
  // }

  Widget all_free_cource_list() {
    return SizedBox(
      //color: Colors.red,
      height: 234.h,
      width: double.infinity.w,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: homecontroller.freeCourseDataModel.data?.courses?.length,
        itemBuilder: (BuildContext context, index) {
          var course = homecontroller.freeCourseDataModel.data?.courses;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () {
                Get.to(MyCources(), arguments: course?[index].id ?? 0);
              },
              child: Container(
                width: 250.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 177.h,
                      width: 250.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          // height: 50.h,
                          // width: 50.w,
                          imageUrl:
                              '${ApiConstants.publicBaseUrl}/${course?[index].courseThumbnail ?? ''}',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.h),
                            child: Container(
                              // height: 50.h,
                              // width: 50.w,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      //alignment: Alignment.topLeft,
                      // child:
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       left: 10.w, right: 147.w, bottom: 142.h),
                      //   child: Container(
                      //     height: 20.h,
                      //     width: 20.w,
                      //     decoration: const BoxDecoration(
                      //         shape: BoxShape.circle, color: Colors.white),
                      //     child: Center(
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           // toggle(index);
                      //         },
                      //         child: trendingCource[index].buttonStatus == true
                      //             ? Image(
                      //                 image:
                      //                     AssetImage("assets/saveboldblue.png"),
                      //                 height: 10.h,
                      //                 width: 9.w,
                      //               )
                      //             : Image(
                      //                 image: AssetImage("assets/savebold.png"),
                      //                 height: 10.h,
                      //                 width: 9.w,
                      //               ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Text(
                        course?[index].title ?? '',
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: const Color(0XFF000000),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // Text(trendingCource[index].subtitle!,
                    //     style: TextStyle(
                    //         fontFamily: 'Gilroy',
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 15.sp,
                    //         color: const Color(0XFF000000))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget all_categories_list() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: double.infinity.w,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: homecontroller.categoriesData.value.data!.categories!
              .take(5)
              .map((category) {
            return GestureDetector(
              onTap: () {
                Get.to(SubCategoriesScreen(
                  category: category,
                ));
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: WidgetStateColor.transparent,
                    border: Border.all(color: Colors.black)),
                child: Text(
                  category.title.toString(),
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: const Color(0XFF000000),
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget recent_added_list() {
    return Container(
      color: const Color(0XFFFFFFFF),
      height: 323.h,
      width: double.infinity.w,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemCount: recentAdded.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(RecentCourceDetail(
                  corcedetail: recentAdded[index],
                ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  //height: 323,
                  width: 276.w,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0XFF503494).withOpacity(0.14),
                            offset: const Offset(-4, 5),
                            blurRadius: 16),
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 158.h,
                        width: 276.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: AssetImage(
                                recentAdded[index].image!,
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 230.w, bottom: 120.h, top: 10.h),
                          child: Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                  splashRadius: 10,
                                  onPressed: () {
                                    toggleRecent(index);
                                  },
                                  icon: Center(
                                    child:
                                        recentAdded[index].buttonStatus == true
                                            ? Image(
                                                image: AssetImage(
                                                    "assets/saveboldblue.png"),
                                                height: 10.h,
                                                width: 9.w,
                                              )
                                            : Image(
                                                image: AssetImage(
                                                    "assets/savebold.png"),
                                                height: 10.h,
                                                width: 9.w,
                                              ),
                                  ))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, top: 10.h),
                            child: Container(
                              height: 25.h,
                              width: 58.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0XFFFAF4E1),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image:
                                        const AssetImage("assets/staricon.png"),
                                    height: 17.h,
                                    width: 17.w,
                                  ),
                                  Text(
                                    recentAdded[index].review!,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        color: const Color(0XFFFFC403),
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Row(
                              children: [
                                Image(
                                  image: const AssetImage("assets/clock.png"),
                                  height: 17.h,
                                  width: 17.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  recentAdded[index].time!,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0XFF000000),
                                      fontFamily: 'Gilroy'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Text(
                          recentAdded[index].title!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: Color(0XFF000000),
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                      SizedBox(height: 11.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                      recentAdded[index].circleimage!),
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  recentAdded[index].personname!,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0XFF503494),
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            Container(
                              height: 33.h,
                              width: 76.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0XFFE5ECFF),
                              ),
                              child: Center(
                                  child: Text(
                                recentAdded[index].price!,
                                style: TextStyle(
                                    color: const Color(0XFF503494),
                                    fontFamily: 'Gilroy',
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
