// import 'dart:collection';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:edxera/chate/Controllers/get_chat_heads_controller.dart';
// import 'package:edxera/chate/chat_list_instructor.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../languagecontrols/LanguageCheck.dart';
// import '../models/chate_data.dart';
// import '../repositories/api/api_constants.dart';
// import '../utils/screen_size.dart';
// import '../utils/shared_pref.dart';
// import '../utils/slider_page_data_model.dart';
// import 'detail_chate.dart';

// class ChateScreen extends StatefulWidget {
//   const ChateScreen({Key? key}) : super(key: key);

//   @override
//   State<ChateScreen> createState() => _ChateScreenState();
// }

// class _ChateScreenState extends State<ChateScreen> {
//   ChateScreenController chateScreenController = Get.put(ChateScreenController());
//   List<Chate> chate = Utils.getChate();
//   Map<String, dynamic> mplanguage = new HashMap();

//   @override
//   void initState() {
//     chateScreenController.getChatHeadsApi();
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
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Get.to(ChatInstructorListScreen());
//           },
//           backgroundColor: const Color(0XFF503494),
//           child: Image(
//             image: AssetImage("assets/floatingaction.png"),
//             height: 24.h,
//             width: 24.w,
//           )),
//       body: SafeArea(
//         child: Obx(
//           () => Stack(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(height: 20.h),
//                   search_text_field(),
//                   SizedBox(height: 20),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         (chateScreenController.getChatHeadsDataModel.data?.chatHeads ?? []).isNotEmpty
//                             ? SizedBox(
//                                 height: 50.h,
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: chateScreenController.getChatHeadsDataModel.data?.chatHeads?.length,
//                                     itemBuilder: ((context, index) => Padding(
//                                           padding: EdgeInsets.only(left: index == 0 ? 22.w : 10.w, right: 10.w),
//                                           child: Stack(
//                                             children: [
//                                               Container(
//                                                 height: 50.h,
//                                                 width: 50.w,
//                                                 // decoration: BoxDecoration(
//                                                 //   image: DecorationImage(
//                                                 //     image: NetworkImage(
//                                                 //         '${ApiConstants.publicBaseUrl}/${chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].mediaFile ?? ''}'),
//                                                 //   ),
//                                                 // ),
//                                                 child: CachedNetworkImage(
//                                                   imageUrl:
//                                                       '${ApiConstants.publicBaseUrl}/${chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].mediaFile ?? ''}',
//                                                   progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                                                     child: Container(
//                                                       height: 30.h,
//                                                       width: 30.w,
//                                                       child: CircularProgressIndicator(value: downloadProgress.progress),
//                                                     ),
//                                                   ),
//                                                   errorWidget: (context, url, error) => ClipRRect(
//                                                     borderRadius: BorderRadius.circular(50 / 2),
//                                                     child: Container(
//                                                       height: 50.h,
//                                                       width: 50.h,
//                                                       color: Colors.grey.withOpacity(0.2),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 // child: Padding(
//                                                 //   padding: EdgeInsets.only(
//                                                 //       top: 36.h, left: 35.h),
//                                                 //   child: Image(
//                                                 //     image: AssetImage(
//                                                 //         "assets/notification.png"),
//                                                 //     height: 10.h,
//                                                 //     width: 10.w,
//                                                 //   ),
//                                                 // ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(top: 36.h, left: 35.h),
//                                                 child: Image(
//                                                   image: AssetImage("assets/notification.png"),
//                                                   height: 10.h,
//                                                   width: 10.w,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ))),
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height / 3,
//                                   ),
//                                   Center(
//                                       child: Text(
//                                     mplanguage['nodata'].toString(),
//                                     style: TextStyle(color: Colors.black),
//                                   )),
//                                 ],
//                               ),
//                         SizedBox(height: 20.h),
//                         GetBuilder(
//                           init: ChateScreenController(),
//                           id: 'Filter',
//                           builder: (controller) {
//                             return (chateScreenController.searchResult.length) > 0 || chateScreenController.searchcontroller.text != ''
//                                 ? ListView.builder(
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.vertical,
//                                     itemCount: chateScreenController.searchResult.length,
//                                     itemBuilder: ((context, index) => GestureDetector(
//                                           onTap: () {
//                                             Get.to(DetailChate(
//                                               name: chateScreenController.searchResult[index].sentBy ?? '',
//                                               detail: (chateScreenController.searchResult[index].instructorId ?? 0).toString(),
//                                               imege: '${ApiConstants.publicBaseUrl}/${chateScreenController.searchResult[index].mediaFile ?? ''}',
//                                             ));
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
//                                             child: Container(
//                                                 height: 70.h,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(12.h),
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                           color: const Color(0XFF503494).withOpacity(0.14),
//                                                           offset: const Offset(-4, 5),
//                                                           blurRadius: 16.h),
//                                                     ],
//                                                     color: Colors.white),
//                                                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                   //SizedBox(width: 10),

//                                                   //const SizedBox(width: 10),
//                                                   Row(
//                                                     children: [
//                                                       SizedBox(width: 10.w),
//                                                       Stack(
//                                                         children: [
//                                                           Container(
//                                                             height: 50.h,
//                                                             width: 50.w,
//                                                             // decoration: BoxDecoration(
//                                                             //   image: DecorationImage(
//                                                             //     image: NetworkImage(
//                                                             //         '${ApiConstants.publicBaseUrl}/${chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].mediaFile ?? ''}'),
//                                                             //   ),
//                                                             // ),
//                                                             child: CachedNetworkImage(
//                                                               imageUrl:
//                                                                   '${ApiConstants.publicBaseUrl}/${chateScreenController.searchResult[index].mediaFile ?? ''}',
//                                                               progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                                                                 child: Container(
//                                                                   height: 30.h,
//                                                                   width: 30.w,
//                                                                   child: CircularProgressIndicator(value: downloadProgress.progress),
//                                                                 ),
//                                                               ),
//                                                               errorWidget: (context, url, error) => ClipRRect(
//                                                                 borderRadius: BorderRadius.circular(50 / 2),
//                                                                 child: Container(
//                                                                   height: 50.h,
//                                                                   width: 50.h,
//                                                                   color: Colors.grey.withOpacity(0.2),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             // child: Padding(
//                                                             //   padding: EdgeInsets.only(
//                                                             //       top: 36.h, left: 35.h),
//                                                             //   child: Image(
//                                                             //     image: AssetImage(
//                                                             //         "assets/notification.png"),
//                                                             //     height: 10.h,
//                                                             //     width: 10.w,
//                                                             //   ),
//                                                             // ),
//                                                           ),
//                                                           Padding(
//                                                             padding: EdgeInsets.only(top: 36.h, left: 35.h),
//                                                             child: Image(
//                                                               image: AssetImage("assets/notification.png"),
//                                                               height: 10.h,
//                                                               width: 10.w,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(width: 15.w),
//                                                       Column(
//                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                         mainAxisAlignment: MainAxisAlignment.center,
//                                                         children: [
//                                                           Text(
//                                                             chateScreenController.searchResult[index].sentBy ?? '',
//                                                             style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: 'Gilroy'),
//                                                           ),
//                                                           SizedBox(height: 2.h),
//                                                           Text(
//                                                             chateScreenController.searchResult[index].lastMessage ?? '',
//                                                             style: TextStyle(
//                                                                 fontSize: 12.sp,
//                                                                 fontWeight: FontWeight.w400,
//                                                                 fontFamily: 'Gilroy',
//                                                                 color: const Color(0XFF6E758A)),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(right: 10.w),
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                       children: [
//                                                         Text(chateScreenController.searchResult[index].sentTime ?? '',
//                                                             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
//                                                         SizedBox(height: 4.h),
//                                                         Container(
//                                                             height: 16.h,
//                                                             width: 16.w,
//                                                             decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0XFF503494)),
//                                                             child: Center(
//                                                                 child: Text('1',
//                                                                     style: TextStyle(
//                                                                         fontSize: 9.sp,
//                                                                         fontWeight: FontWeight.w700,
//                                                                         fontFamily: 'Gilroy',
//                                                                         color: Color(0XFFFFFFFF)))))
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ])),
//                                           ),
//                                         )),
//                                   )
//                                 : chateScreenController.getChatHeadsDataModel.data != null
//                                     ? ListView.builder(
//                                         physics: const NeverScrollableScrollPhysics(),
//                                         shrinkWrap: true,
//                                         scrollDirection: Axis.vertical,
//                                         itemCount: chateScreenController.getChatHeadsDataModel.data?.chatHeads?.length,
//                                         itemBuilder: ((context, index) => GestureDetector(
//                                               onTap: () {
//                                                 Get.to(DetailChate(
//                                                   name: chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].sentBy ?? '',
//                                                   detail: (chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].instructorId ?? 0)
//                                                       .toString(),
//                                                   imege:
//                                                       '${ApiConstants.publicBaseUrl}/${chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].mediaFile ?? ''}',
//                                                 ));
//                                               },
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
//                                                 child: Container(
//                                                     height: 70.h,
//                                                     decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(12.h),
//                                                         boxShadow: [
//                                                           BoxShadow(
//                                                               color: const Color(0XFF503494).withOpacity(0.14),
//                                                               offset: const Offset(-4, 5),
//                                                               blurRadius: 16.h),
//                                                         ],
//                                                         color: Colors.white),
//                                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                       //SizedBox(width: 10),

//                                                       //const SizedBox(width: 10),
//                                                       Row(
//                                                         children: [
//                                                           SizedBox(width: 10.w),
//                                                           Stack(
//                                                             children: [
//                                                               Container(
//                                                                 height: 50.h,
//                                                                 width: 50.w,
//                                                                 // decoration: BoxDecoration(
//                                                                 //   image: DecorationImage(
//                                                                 //     image: NetworkImage(
//                                                                 //         '${ApiConstants.publicBaseUrl}/${chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].mediaFile ?? ''}'),
//                                                                 //   ),
//                                                                 // ),
//                                                                 child: CachedNetworkImage(
//                                                                   imageUrl:
//                                                                       '${ApiConstants.publicBaseUrl}/${chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].mediaFile ?? ''}',
//                                                                   progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                                                                     child: Container(
//                                                                       height: 30.h,
//                                                                       width: 30.w,
//                                                                       child: CircularProgressIndicator(value: downloadProgress.progress),
//                                                                     ),
//                                                                   ),
//                                                                   errorWidget: (context, url, error) => ClipRRect(
//                                                                     borderRadius: BorderRadius.circular(50 / 2),
//                                                                     child: Container(
//                                                                       height: 50.h,
//                                                                       width: 50.h,
//                                                                       color: Colors.grey.withOpacity(0.2),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 // child: Padding(
//                                                                 //   padding: EdgeInsets.only(
//                                                                 //       top: 36.h, left: 35.h),
//                                                                 //   child: Image(
//                                                                 //     image: AssetImage(
//                                                                 //         "assets/notification.png"),
//                                                                 //     height: 10.h,
//                                                                 //     width: 10.w,
//                                                                 //   ),
//                                                                 // ),
//                                                               ),
//                                                               Padding(
//                                                                 padding: EdgeInsets.only(top: 36.h, left: 35.h),
//                                                                 child: Image(
//                                                                   image: AssetImage("assets/notification.png"),
//                                                                   height: 10.h,
//                                                                   width: 10.w,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           SizedBox(width: 15.w),
//                                                           Column(
//                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                             mainAxisAlignment: MainAxisAlignment.center,
//                                                             children: [
//                                                               Text(
//                                                                 chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].sentBy ?? '',
//                                                                 style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: 'Gilroy'),
//                                                               ),
//                                                               SizedBox(height: 2.h),
//                                                               Text(
//                                                                 chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].lastMessage ?? '',
//                                                                 style: TextStyle(
//                                                                     fontSize: 12.sp,
//                                                                     fontWeight: FontWeight.w400,
//                                                                     fontFamily: 'Gilroy',
//                                                                     color: const Color(0XFF6E758A)),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Padding(
//                                                         padding: EdgeInsets.only(right: 10.w),
//                                                         child: Column(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: [
//                                                             Text(chateScreenController.getChatHeadsDataModel.data?.chatHeads?[index].sentTime ?? '',
//                                                                 style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
//                                                             SizedBox(height: 4.h),
//                                                             Container(
//                                                                 height: 16.h,
//                                                                 width: 16.w,
//                                                                 decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0XFF503494)),
//                                                                 child: Center(
//                                                                     child: Text('1',
//                                                                         style: TextStyle(
//                                                                             fontSize: 9.sp,
//                                                                             fontWeight: FontWeight.w700,
//                                                                             fontFamily: 'Gilroy',
//                                                                             color: Color(0XFFFFFFFF)))))
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ])),
//                                               ),
//                                             )),
//                                       )
//                                     : Container();
//                           },
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               if (chateScreenController.isloader.value)
//                 SafeArea(
//                   top: false,
//                   bottom: false,
//                   child: ColoredBox(
//                     color: Colors.white.withOpacity(0.5),
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(.1),
//                               spreadRadius: 0.1,
//                               offset: const Offset(0.0, 0.0),
//                               blurRadius: 5.0,
//                             ),
//                           ],
//                         ),
//                         height: 80,
//                         width: 80,
//                         child: Platform.isIOS
//                             ? const CupertinoActivityIndicator(
//                                 animating: true,
//                                 color: Color(0XFF503494),
//                               )
//                             : const Padding(
//                                 padding: EdgeInsets.all(25),
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 3.0,
//                                   color: Color(0XFF503494),
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget search_text_field() {
//     return Padding(
//       padding: EdgeInsets.only(left: 20.w, right: 20.w),
//       child: Container(
//         height: 50,
//         child: TextFormField(
//             controller: chateScreenController.searchcontroller,
//             onChanged: chateScreenController.onSearchTextChanged,
//             decoration: InputDecoration(
//               focusedBorder:
//                   OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
//               hintText: mplanguage['search'].toString(),
//               hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
//               prefixIcon: const Image(
//                 image: AssetImage('assets/search.png'),
//                 height: 24,
//                 width: 24,
//               ),
//               enabledBorder:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
//             )),
//       ),
//     );
//   }
// }
