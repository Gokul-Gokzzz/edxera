// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/home/Models/study_matrial_video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../repositories/api/api_constants.dart';
import 'image_viewer_screen.dart';
import 'package:http/http.dart' as http;

class StudyMatrialListScreen extends StatefulWidget {
  String subjectVideoName;
  List<SubChapterFiles>? subChapterFiles;
  List<OtherFiles>? otherFiles;

  StudyMatrialListScreen(
      {super.key,
      required this.subjectVideoName,
      this.otherFiles,
      this.subChapterFiles});

  @override
  State<StudyMatrialListScreen> createState() => _StudyMatrialListScreenState();
}

class _StudyMatrialListScreenState extends State<StudyMatrialListScreen> {
  late PageController pController;

  @override
  void initState() {
    pController = PageController();
    super.initState();
  }

  String extractFileName(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
  }

  Future<void> handleNavigation({
    required BuildContext context,
    String? name,
    String? path,
    // String? youtubeLink,
    // String? videoContent,
  }) async {
    // if (youtubeLink != null && youtubeLink.isNotEmpty) {
    //   /// Handle navigation to YouTube
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => YoutubeVideoPlayerScreen(url: youtubeLink), // Replace with your YouTube Viewer screen
    //     ),
    //   );
    // } else if (videoContent != null) {
    //   /// Handle navigation for other video content
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => VidioPlay(lessonplay: '${ApiConstants.publicBaseUrl}/$videoContent'), // Replace with your Video Player screen
    //     ),
    //   );
    // } else

    if (path != null && path.contains('pdf')) {
      /// Handle navigation for PDF
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViwersScreen(
            name: name ?? '',
            path: '${ApiConstants.publicBaseUrl}/$path',
          ),
        ),
      );
    } else if (path != null &&
        (path.contains('jpg') ||
            path.contains('jpeg') ||
            path.contains('png'))) {
      /// Handle navigation for images or other study materials
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewerScreen(
            path: '${ApiConstants.publicBaseUrl}/$path',
          ),
        ),
      );
    } else {
      //   final uri = Uri.parse('${ApiConstants.publicBaseUrl}/${path ?? ''}');

      //   /// Handle other file types: Download and show Snackbar
      //   try {
      Get.snackbar(
        'No Material', // Title
        '', // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.blue.shade300, // Background color
        colorText: Colors.white, // Text color
        duration: Duration(seconds: 2), // Duration before disappearing
      );

      //     /// Download file
      //     final response = await http.get(uri);
      //     if (response.statusCode == 200) {
      //       // Get the appropriate directory
      //       Directory? directory;
      //       // Request permission for accessing storage on Android
      //       final status = await Permission.storage.request();
      //       if (status.isDenied || status.isPermanentlyDenied) {
      //         Get.showSnackbar(
      //           GetSnackBar(
      //             backgroundColor: Colors.red,
      //             message: "Storage permission is required to download the file.",
      //             duration: const Duration(seconds: 1),
      //           ),
      //         );

      //         return;
      //       }
      //       if (Platform.isAndroid) {
      //         directory = Directory('/storage/emulated/0/Download');
      //       } else if (Platform.isIOS) {
      //         directory = await getApplicationDocumentsDirectory();
      //       } else {
      //         Get.showSnackbar(
      //           GetSnackBar(
      //             backgroundColor: Colors.red,
      //             message: "Failed to download file",
      //             duration: const Duration(seconds: 1),
      //           ),
      //         );
      //       }
      //       if (directory != null) {
      //         /// Ensure the directory exists
      //         if (!(await directory.exists())) {
      //           await directory.create(recursive: true);
      //         }

      //         /// Save the file
      //         final file = File('${directory.path}/${extractFileName(uri.toString())}');
      //         await file.writeAsBytes(response.bodyBytes);
      //         final openUrl = Uri.file(file.path);
      //         if (await canLaunchUrl(openUrl)) {
      //           await launchUrl(uri);
      //         } else {}
      //         Get.showSnackbar(
      //           GetSnackBar(
      //             backgroundColor: Colors.green,
      //             message: "File downloaded Successfully",
      //             duration: const Duration(seconds: 1),
      //           ),
      //         );
      //       }
      //     } else {
      //       Get.showSnackbar(
      //         GetSnackBar(
      //           backgroundColor: Colors.red,
      //           message: "Failed to download file",
      //           duration: const Duration(seconds: 1),
      //         ),
      //       );
      //     }
      //   } catch (e) {
      //     Get.showSnackbar(
      //       GetSnackBar(
      //         backgroundColor: Colors.red,
      //         message: "Failed to download file",
      //         duration: const Duration(seconds: 1),
      //       ),
      //     );
      //   }
    }
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
        titleSpacing: 0,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        centerTitle: false,
        title: Text(
          "${widget.subjectVideoName}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            search_text_field(),
            SizedBox(height: 20.h),
            if (widget.otherFiles?.length != 0)
              ListView.builder(
                itemCount: widget.otherFiles?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      handleNavigation(
                        context: context,
                        name: widget.otherFiles?[index].otherFilesNotes ?? '',
                        path:
                            widget.otherFiles?[index].otherFilesStudyMaterials,
                        // videoContent: widget.otherFiles?[index].otherFilesVideos,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0XFF503494).withOpacity(0.14),
                                offset: const Offset(-4, 5),
                                blurRadius: 16.h),
                          ],
                          color: Colors.white),
                      child: Container(
                        margin: EdgeInsets.all(10.w),
                        child: Text(
                          (widget.otherFiles?[index].otherFilesNotes ?? "")
                                  .isNotEmpty
                              ? widget.otherFiles![index].otherFilesNotes!
                              : '${index + 1}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (widget.subChapterFiles?.length != 0)
              ListView.builder(
                itemCount: widget.subChapterFiles?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      handleNavigation(
                        context: context,
                        name: widget.subChapterFiles?[index].subChaptersNotes ??
                            '',
                        path: widget
                            .subChapterFiles?[index].subChaptersStudyMaterials,
                        // youtubeLink: widget.subChapterFiles?[index].subChapterYoutubeLink,
                        // videoContent: widget.subChapterFiles?[index].subChaptersVideos,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0XFF503494).withOpacity(0.14),
                                offset: const Offset(-4, 5),
                                blurRadius: 16.h),
                          ],
                          color: Colors.white),
                      child: Container(
                        margin: EdgeInsets.all(10.w),
                        child: Text(
                          (widget.subChapterFiles?[index].subChaptersNotes !=
                                      null &&
                                  widget.subChapterFiles![index]
                                      .subChaptersNotes!.isNotEmpty)
                              ? widget.subChapterFiles![index].subChaptersNotes!
                              : '${index + 1}'.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              )
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
            decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF503494), width: 1.w),
              borderRadius: BorderRadius.circular(22)),
          hintText: 'Search',
          hintStyle: TextStyle(
              color: Color(0XFF9B9B9B),
              fontSize: 15.sp,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400),
          prefixIcon: const Image(
            image: AssetImage('assets/search.png'),
            height: 24,
            width: 24,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22.h),
              borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
        )),
      ),
    );
  }
}
