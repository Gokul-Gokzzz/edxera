import 'dart:io';

import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/image_viewer_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/study_matrial_list_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/video_list_screen.dart';
import 'package:edxera/home/Models/study_matrial_video_data_model.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../repositories/api/api_constants.dart';
import 'package:http/http.dart' as http;

class SubChapterViewScreen extends StatefulWidget {
  final ChapterListForUser? data;
  final String subjectVideoName;
  final bool isVideoScreen;

  const SubChapterViewScreen({super.key, required this.data, required this.subjectVideoName, required this.isVideoScreen});

  @override
  State<SubChapterViewScreen> createState() => _SubChapterViewScreenState();
}

class _SubChapterViewScreenState extends State<SubChapterViewScreen> {
  @override
  void initState() {
    // _batchVideoController.batchVideoListApi(widget.batchid);
    if (widget.isVideoScreen) {
      genrateThumb();
    }

    super.initState();
  }

  String? fileName = '';

  void genrateThumb() async {
    fileName = await VideoThumbnail.thumbnailFile(
      video: (widget.data?.videos != '' && widget.data?.videos != null)
          ? "${ApiConstants.publicBaseUrl}/${widget.data?.videos ?? ''}"
          : widget.data?.youtubelink ?? '',
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    setState(() {});
    print(fileName);
  }

  String extractFileName(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
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
          maxLines: 5,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SafeArea(
        child: widget.data != null
            ? Column(
                children: [
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () async {
                      if (widget.isVideoScreen) {
                        if (widget.data?.videos != '') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VidioPlay(lessonplay: '${ApiConstants.publicBaseUrl}/${widget.data?.videos ?? ''}'),
                            ),
                          );
                        } else {
                          Get.to(() => YoutubeVideoPlayerScreen(url: widget.data?.youtubelink ?? ''));
                        }
                      } else {
                        if (widget.data?.studyMaterials != '') {
                          if (widget.data!.studyMaterials!.contains('pdf')) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViwersScreen(
                                        name: widget.data?.chaptersNotes ?? '',
                                        path: '${ApiConstants.publicBaseUrl}/${widget.data?.studyMaterials ?? ''}')));
                          } else if (widget.data!.studyMaterials!.contains('jpg') ||
                              widget.data!.studyMaterials!.contains('jpeg') ||
                              widget.data!.studyMaterials!.contains('png')) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ImageViewerScreen(path: '${ApiConstants.publicBaseUrl}/${widget.data?.studyMaterials ?? ''}')));
                          } else {
                            final uri = Uri.parse('${ApiConstants.publicBaseUrl}/${widget.data?.studyMaterials ?? ''}');

                            /// Handle other file types: Download and show Snackbar
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Downloading file...')),
                              );

                              /// Download file
                              final response = await http.get(uri);
                              if (response.statusCode == 200) {
                                // Get the appropriate directory
                                Directory? directory;
                                // Request permission for accessing storage on Android
                                final status = await Permission.storage.request();
                                if (status.isDenied || status.isPermanentlyDenied) {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      backgroundColor: Colors.red,
                                      message: "Storage permission is required to download the file.",
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );

                                  return;
                                }
                                if (Platform.isAndroid) {
                                  directory = Directory('/storage/emulated/0/Download');
                                } else if (Platform.isIOS) {
                                  directory = await getApplicationDocumentsDirectory();
                                } else {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      backgroundColor: Colors.red,
                                      message: "Failed to download file",
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                }
                                if (directory != null) {
                                  /// Ensure the directory exists
                                  if (!(await directory.exists())) {
                                    await directory.create(recursive: true);
                                  }

                                  /// Save the file
                                  final file = File('${directory.path}/${extractFileName(uri.toString())}');
                                  await file.writeAsBytes(response.bodyBytes);
                                  final openUrl = Uri.file(file.path);
                                  if (await canLaunchUrl(openUrl)) {
                                    await launchUrl(uri);
                                  } else {}
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      backgroundColor: Colors.green,
                                      message: "File downloaded Successfully",
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                }
                              } else {
                                Get.showSnackbar(
                                  GetSnackBar(
                                    backgroundColor: Colors.red,
                                    message: "Failed to download file",
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            } catch (e) {
                              Get.showSnackbar(
                                GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message: "Failed to download file",
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          }
                        }
                      }
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
                        margin: EdgeInsets.all(15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            fileName != ''
                                ? Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.h), color: Colors.grey.withOpacity(0.2)),

                                    height: 80.h,
                                    width: 100.h,
                                    // width: 100.0,
                                    // height: 56.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        File(fileName ?? ''),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10.w,
                            ),
                            Wrap(
                              children: [
                                widget.isVideoScreen && (widget.data?.youtubelink != '' || widget.data?.videos != '')
                                    ? Text(
                                        '1. ${widget.data?.chaptersTitle ?? ''}',
                                        maxLines: 5,
                                        style: TextStyle(
                                            color: Color(0XFF503494),
                                            fontSize: 15.sp,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    : (!widget.isVideoScreen) && widget.data?.studyMaterials != ''
                                        ? SizedBox()
                                        : Container(
                                            child: Text(
                                              'No Study Material!',
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                widget.isVideoScreen && (widget.data?.videos != '' || widget.data?.youtubelink != '')
                                    ? Container()
                                    : SizedBox(
                                        width: 10.w,
                                      ),
                                if (!widget.isVideoScreen && widget.data?.studyMaterials != '')
                                  Text(
                                    (widget.data?.chaptersTitle ?? '').toUpperCase(),
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Color(0XFF503494),
                                        fontSize: 15.sp,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if ((widget.data?.subChapterFiles?.length ?? 0) > 0)
                    InkWell(
                      onTap: () {
                        if (widget.isVideoScreen) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoListScreen(
                                subjectVideoName: 'Sub Chapters',
                                subChapterFiles: widget.data?.subChapterFiles,
                                otherFiles: [],
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudyMatrialListScreen(
                                subjectVideoName: 'Sub Chapters',
                                subChapterFiles: widget.data?.subChapterFiles,
                                otherFiles: [],
                              ),
                            ),
                          );
                        }
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
                          margin: EdgeInsets.all(15.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder,
                                color: Color(0XFF503494),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Sub Chapters',
                                style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if ((widget.data?.otherFiles?.length ?? 0) > 0)
                    InkWell(
                      onTap: () {
                        if (widget.isVideoScreen) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoListScreen(
                                subjectVideoName: 'Others Files',
                                otherFiles: widget.data?.otherFiles,
                                subChapterFiles: [],
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudyMatrialListScreen(
                                subjectVideoName: 'Others Files',
                                otherFiles: widget.data?.otherFiles,
                                subChapterFiles: [],
                              ),
                            ),
                          );
                        }
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
                          margin: EdgeInsets.all(15.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder,
                                color: Color(0XFF503494),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Others Files',
                                style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //    Spacer(),
                    Icon(
                      Icons.assignment_add,
                      color: Color(0XFF503494),
                    ),
                    Center(
                      child: Text(
                        'No assignment created yet!',
                        style: TextStyle(color: Color(0XFF503494), fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
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
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
          prefixIcon: const Image(
            image: AssetImage('assets/search.png'),
            height: 24,
            width: 24,
          ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
        )),
      ),
    );
  }
}
