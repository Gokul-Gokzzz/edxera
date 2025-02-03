import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/batchs/controllers/study_plan_assigment_controller.dart';
import 'package:edxera/utils/dynamic_file_viewer.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' as html_widget;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../repositories/api/api_constants.dart';
import '../../../utils/shared_pref.dart';

class StudyPlanAssigmentScreen extends StatefulWidget {
  final String title, assigmentid, studyPlanId;

  const StudyPlanAssigmentScreen({super.key, required this.title, required this.assigmentid, required this.studyPlanId});

  @override
  State<StudyPlanAssigmentScreen> createState() => _StudyPlanAssigmentScreenState();
}

class _StudyPlanAssigmentScreenState extends State<StudyPlanAssigmentScreen> {
  StudyPlanAssigmentController _assigmentController = Get.put(StudyPlanAssigmentController());
  final _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    _assigmentController.assigmentDataApi(widget.assigmentid, widget.studyPlanId);
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

  Future<void> _openImagePicker(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      print("Hello$_image");
    }
  }

  Future<void> _openVideoPicker(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickVideo(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      print("Hello$_image");
    }
  }

  void imagePoup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openImagePicker(ImageSource.camera);

                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                color: Colors.grey,
                                size: 50,
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _openImagePicker(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.grey,
                            size: 50,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'CANCEL',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void videoPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openVideoPicker(ImageSource.camera);

                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                color: Colors.grey,
                                size: 50,
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _openVideoPicker(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.grey,
                            size: 50,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'CANCEL',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void mediaPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  mplanguage['choose'].toString(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          imagePoup();
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                color: Colors.grey,
                                size: 50,
                              ),
                              Text(
                                mplanguage['image'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      videoPopup();
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.video_camera_back_outlined,
                            color: Colors.grey,
                            size: 50,
                          ),
                          Text(
                            mplanguage['video'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      filePicker();
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.file_present_rounded,
                            color: Colors.grey,
                            size: 50,
                          ),
                          Text(
                            mplanguage['file'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    mplanguage['cancel'].toString(),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _image = File(result.files.single.path!);
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${ApiConstants.publicBaseUrl}/${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? ''}');
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
        centerTitle: false,
        title: Text(
          widget.title,
          maxLines: 4,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black, overflow: TextOverflow.ellipsis),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    mplanguage['title'].toString() + ': ${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.title ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${mplanguage['description']} :",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp, color: Colors.black),
                  ),
                  html_widget.HtmlWidget(
                    _assigmentController.studyPlanAssigmentDataModel.data?.assignment?.description ?? '',

                    // this callback will be triggered when user taps a link
                    onTapUrl: (url) async {
                      if (url.isNotEmpty) {
                        final Uri uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      }
                      return true;
                    },

                    renderMode: html_widget.RenderMode.column,

                    textStyle: TextStyle(fontSize: 14),
                  ),
                  if ((_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? '') != '')
                    SizedBox(
                      height: 10.h,
                    ),

                  if ((_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? '') != '')
                    DynamicFileViewer(
                      fileUrl: _assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? '',
                    ),
                  // if ((_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? '') != '')
                  //   Container(
                  //     height: 200,
                  //     width: double.infinity,
                  //     // decoration: BoxDecoration(
                  //     //   image: DecorationImage(
                  //     //       image:
                  //     //       // NetworkImage(
                  //     //       //   '${ApiConstants.publicBaseUrl}/${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? ''}',
                  //     //       // ),
                  //     //       fit: BoxFit.fill),
                  //     // ),
                  //     child: CachedNetworkImage(
                  //       imageUrl: '${ApiConstants.publicBaseUrl}/${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.file ?? ''}',
                  //       progressIndicatorBuilder: (context, url, downloadProgress) =>
                  //           SizedBox(height: 25, width: 25, child: Center(child: CircularProgressIndicator(value: downloadProgress.progress))),
                  //       errorWidget: (context, url, error) => Icon(Icons.error),
                  //     ),
                  //   ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _assigmentController.answerController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.h))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.h), borderSide: BorderSide(color: Color(0XFF503494), width: 1.w)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.h), borderSide: BorderSide(color: Color(0XFFDFDFDF), width: 1.w)),
                          hintText: mplanguage['writeyourassignment'].toString(),
                          hintStyle: TextStyle(color: Color(0XFF6E758A), fontSize: 16.sp)),
                      maxLines: 10,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    mplanguage['or'].toString(),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
                  ),
                  if (_image != null)
                    SizedBox(
                      height: 15.h,
                    ),
                  _image == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _image?.path.split('/').last ?? '',
                            maxLines: 3,
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
                          ),
                        ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      mediaPopup();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h / 2),
                        color: const Color(0XFF503494),
                      ),
                      height: 50.h,
                      margin: EdgeInsets.only(left: 50.w, right: 50.w),
                      child: Text(
                        mplanguage['selectfileimagepdf'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_assigmentController.answerController.text == '' && _image == null) {
                        Get.showSnackbar(
                          GetSnackBar(
                            backgroundColor: Colors.red,
                            message: mplanguage['pleasewritorselect'].toString(),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                        return;
                      }

                      _assigmentController.submitAssigment(widget.assigmentid, widget.studyPlanId, _image?.path ?? '',
                          _assigmentController.studyPlanAssigmentDataModel.data?.assignment?.title ?? '', _assigmentController.answerController.text);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h / 2),
                        color: Colors.green,
                      ),
                      height: 50.h,
                      margin: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        mplanguage['submit'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    mplanguage['totalmarksofexam'].toString() +
                        ': ${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.totalMarks ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    mplanguage['passmarks'].toString() + ': ${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.passMarks ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    mplanguage['deadlinedate'].toString() + ': ${_assigmentController.studyPlanAssigmentDataModel.data?.assignment?.deadline ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
            if (_assigmentController.isloader.value)
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
}
