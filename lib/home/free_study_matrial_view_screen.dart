import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../repositories/api/api_constants.dart';
import '../utils/shared_pref.dart';

class FreeStudyMatrialViewScreen extends StatefulWidget {
  const FreeStudyMatrialViewScreen({super.key});

  @override
  State<FreeStudyMatrialViewScreen> createState() => _FreeStudyMatrialViewScreenState();
}

class _FreeStudyMatrialViewScreenState extends State<FreeStudyMatrialViewScreen> {
  //FreeStudyMatrialController
  FreeStudyMatrialController freeStudyMatrialController = Get.put(FreeStudyMatrialController());
  @override
  void initState() {
    freeStudyMatrialController.homeDashboardTrendingDatGetApi('');
    super.initState();
    checkLanguage();
  }

  Map<String, dynamic> mplanguage = new HashMap();

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: Text(
          mplanguage['freestudymaterial'].toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                search_text_field(),
                SizedBox(height: 20.h),
                (freeStudyMatrialController.freeStudyMatrialListDataModel.data?.freeStudyMaterials?.length ?? 0) > 0
                    ? Expanded(
                        child: PageView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return ListView.builder(
                              itemCount: freeStudyMatrialController.freeStudyMatrialListDataModel.data?.freeStudyMaterials?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PdfViwersScreen(
                                                name:
                                                    freeStudyMatrialController.freeStudyMatrialListDataModel.data?.freeStudyMaterials?[index].notes ??
                                                        '',
                                                path:
                                                    '${ApiConstants.publicBaseUrl}/${freeStudyMatrialController.freeStudyMatrialListDataModel.data?.freeStudyMaterials?[index].pdf ?? ''}')));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                                    width: double.infinity.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.h),
                                        boxShadow: [
                                          BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                        ],
                                        color: Colors.white),
                                    child: Container(
                                      margin: EdgeInsets.all(10.w),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/pdf.png'), fit: BoxFit.fill)),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            (freeStudyMatrialController.freeStudyMatrialListDataModel.data?.freeStudyMaterials?[index].title ?? '')
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                                // InkWell(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             FreeMatrialPdfListScreen(
                                //           subjectVideoName: freeStudyMatrialController
                                //                   .freeStudyMatrialListDataModel
                                //                   .data
                                //                   ?.freeStudyMaterials?[index]
                                //                   .notes ??
                                //               '',
                                //           subChapterFiles: [],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: Container(
                                //     margin: EdgeInsets.only(
                                //         left: 15.w,
                                //         right: 15.w,
                                //         bottom: 7.5.w,
                                //         top: 7.5.w),
                                //     width: double.infinity.w,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10.h),
                                //         boxShadow: [
                                //           BoxShadow(
                                //               color: const Color(0XFF503494)
                                //                   .withOpacity(0.14),
                                //               offset: const Offset(-4, 5),
                                //               blurRadius: 16.h),
                                //         ],
                                //         color: Colors.white),
                                //     child: Container(
                                //       margin: EdgeInsets.all(15.w),
                                //       child: Row(
                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                //         children: [
                                //           Icon(
                                //             Icons.folder,
                                //             color: Color(0XFF503494),
                                //           ),
                                //           SizedBox(
                                //             width: 10.w,
                                //           ),
                                //           Text(
                                //             freeStudyMatrialController
                                //                     .freeStudyMatrialListDataModel
                                //                     .data
                                //                     ?.freeStudyMaterials?[index]
                                //                     .notes ??
                                //                 '',
                                //             style: TextStyle(
                                //                 color: Color(0XFF503494),
                                //                 fontSize: 15.sp,
                                //                 fontFamily: 'Gilroy',
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // );
                              },
                            );
                          },
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Text("No Study material found.."),
                        ),
                      )
              ],
            ),
            if (freeStudyMatrialController.isloader.value)
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

  Widget search_text_field() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            controller: freeStudyMatrialController.searchcontroller,
            onChanged: freeStudyMatrialController.onSearchTextChanged,
            decoration: InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
              hintText: mplanguage['search'].toString(),
              hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
              prefixIcon: const Image(
                image: AssetImage('assets/search.png'),
                height: 24,
                width: 24,
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
            )),
      ),
    );
  }
}
