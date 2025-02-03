import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/controllers/exam_mcq_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';

class ExamMcqScreen extends StatefulWidget {
  final String title, examid, studyPlanId, examPogress;
  const ExamMcqScreen({super.key, required this.title, required this.examPogress, required this.examid, required this.studyPlanId});

  @override
  State<ExamMcqScreen> createState() => _ExamMcqScreenState();
}

class _ExamMcqScreenState extends State<ExamMcqScreen> with WidgetsBindingObserver {
  List<String> optionName = ['A', 'B', 'C', 'D'];
  ExamMcqController _examMcqController = Get.put(ExamMcqController());
  late final AppLifecycleListener _listener;
  late Timer _timer;
  int _start = 122;

  String time = "00:00";

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      default:
        break;
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (_examMcqController.examQiestion != _examMcqController.examMcqDataModel.data?.totalQuestionCount) {
            _examMcqController.examQiestion.value += 1;
            _examMcqController.submitAnswer(widget.examid, widget.studyPlanId, _examMcqController.examMcqDataModel.data?.question?.id ?? '', false);
            setState(() {
              _start = 122;
            });
          } else {
            _examMcqController.submitAnswer(widget.examid, widget.studyPlanId, _examMcqController.examMcqDataModel.data?.question?.id ?? '', true);

            setState(() {
              _start = 122;
            });
          }

          // setState(() {
          //   timer.cancel();
          // });
        } else {
          setState(() {
            time = formattedTime(timeInSecond: _start);
            _start--;
          });
        }
      },
    );
  }

  late AppLifecycleState? _state;
  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _handleStateChange(AppLifecycleState state) {
    setState(() {
      _state = state;
    });
  }

  void _handleTransition(String name) {
    if (name.compareTo("detach") == 0) {
      submitanswer();
    }

    print(name);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _examMcqController.examMcqDataApi(widget.examid, widget.studyPlanId);

    super.initState();
    checkLanguage();
    SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () => _handleTransition('show'),
      onResume: () => _handleTransition('resume'),
      onHide: () => _handleTransition('hide'),
      onInactive: () => _handleTransition('inactive'),
      onPause: () => _handleTransition('pause'),
      onDetach: () => _handleTransition('detach'),
      onRestart: () => _handleTransition('restart'),

      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      onStateChange: _handleStateChange,
    );
    startTimer();
  }

  Map<String, dynamic> mplanguage = new HashMap();

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  submitanswer() {
    if (_examMcqController.examQiestion != _examMcqController.examMcqDataModel.data?.totalQuestionCount) {
      _examMcqController.examQiestion.value += 1;
      _examMcqController.submitAnswer(widget.examid, widget.studyPlanId, _examMcqController.examMcqDataModel.data?.question?.id ?? '', false);
      setState(() {
        _start = 122;
      });
    } else {
      _examMcqController.submitAnswer(widget.examid, widget.studyPlanId, _examMcqController.examMcqDataModel.data?.question?.id ?? '', true);
    }
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
        centerTitle: false,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            _examMcqController.examMcqDataModel.data != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          mplanguage['totalexammcq'].toString() +
                              '${_examMcqController.examQiestion}/${_examMcqController.examMcqDataModel.data?.totalQuestionCount}',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _examMcqController.examMcqDataModel.data?.question?.textQuestion ?? '',
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _examMcqController.selectedAnswer.value = 'option_a';
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _examMcqController.selectedAnswer.value == 'option_a' ? const Color(0XFF503494) : Colors.transparent),
                                      boxShadow: [
                                        BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(1000.h / 2),
                                            ),
                                            child: Text(
                                              'A',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _examMcqController.examMcqDataModel.data?.question?.optionA ?? '',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _examMcqController.selectedAnswer.value = 'option_b';
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _examMcqController.selectedAnswer.value == 'option_b' ? const Color(0XFF503494) : Colors.transparent),
                                      boxShadow: [
                                        BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(1000.h / 2),
                                            ),
                                            child: Text(
                                              'B',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _examMcqController.examMcqDataModel.data?.question?.optionB ?? '',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _examMcqController.selectedAnswer.value = 'option_c';
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _examMcqController.selectedAnswer.value == 'option_c' ? const Color(0XFF503494) : Colors.transparent),
                                      boxShadow: [
                                        BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(1000.h / 2),
                                            ),
                                            child: Text(
                                              'C',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _examMcqController.examMcqDataModel.data?.question?.optionC ?? '',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _examMcqController.selectedAnswer.value = 'option_d';
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _examMcqController.selectedAnswer.value == 'option_d' ? const Color(0XFF503494) : Colors.transparent),
                                      boxShadow: [
                                        BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(1000.h / 2),
                                            ),
                                            child: Text(
                                              'D',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _examMcqController.examMcqDataModel.data?.question?.optionD ?? '',
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                (widget.examPogress != 'COMPLETED')
                                    ? Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text('$time'),
                                      )
                                    : Container()

                                // ListView.builder(
                                //   shrinkWrap: true,
                                //   itemCount: 4,
                                //   physics: NeverScrollableScrollPhysics(),
                                //   itemBuilder: (context, index) {
                                //     return Container(
                                //       decoration: BoxDecoration(
                                //         boxShadow: [
                                //           BoxShadow(
                                //               color: const Color(0XFF503494)
                                //                   .withOpacity(0.14),
                                //               offset: const Offset(-4, 5),
                                //               blurRadius: 16),
                                //         ],
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Colors.white,
                                //       ),
                                //       margin: EdgeInsets.all(10),
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             Container(
                                //               height: 30.h,
                                //               width: 30.w,
                                //               alignment: Alignment.center,
                                //               decoration: BoxDecoration(
                                //                 color: Colors.grey
                                //                     .withOpacity(0.2),
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         1000.h / 2),
                                //               ),
                                //               child: Text(
                                //                 optionName[index],
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.w500,
                                //                     fontSize: 20.sp,
                                //                     color: Colors.black),
                                //               ),
                                //             ),
                                //             SizedBox(
                                //               width: 10.w,
                                //             ),
                                //             Expanded(
                                //               child: Text(
                                //                 'sadjhjsahdjkashdjkahsdjkhasjkdhsajkdhajskdhajskdhjaksdhjkasdhjk',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.w500,
                                //                     fontSize: 20.sp,
                                //                     color: Colors.black),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (_examMcqController.examQiestion > 1) {
                                  _examMcqController.examQiestion.value -= 1;
                                  _examMcqController.examMcqDataApi(widget.examid, widget.studyPlanId);

                                  setState(() {
                                    _start = 122;
                                  });
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => LessonDetailsScreens(),
                                //   ),
                                // );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.h / 2),
                                  color: _examMcqController.examQiestion.value != 1 ? const Color(0XFF503494) : Colors.transparent,
                                ),
                                height: 50.h,
                                margin: EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Text(
                                  mplanguage['prev'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: _examMcqController.examQiestion.value != 1 ? Colors.white : Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          if (widget.examPogress != 'COMPLETED')
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (_examMcqController.examQiestion != _examMcqController.examMcqDataModel.data?.totalQuestionCount) {
                                    _examMcqController.examQiestion.value += 1;
                                    _examMcqController.submitAnswer(
                                        widget.examid, widget.studyPlanId, _examMcqController.examMcqDataModel.data?.question?.id ?? '', false);
                                    setState(() {
                                      _start = 122;
                                    });
                                  } else {
                                    _examMcqController.submitAnswer(
                                        widget.examid, widget.studyPlanId, _examMcqController.examMcqDataModel.data?.question?.id ?? '', true);

                                    setState(() {
                                      _start = 122;
                                    });
                                  }
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => LessonDetailsScreens(),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h / 2),
                                    color: const Color(0XFF503494),
                                  ),
                                  height: 50.h,
                                  width: 170.w,
                                  margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: Text(
                                    (_examMcqController.examQiestion == _examMcqController.examMcqDataModel.data?.totalQuestionCount)
                                        ? mplanguage['finish'].toString()
                                        : mplanguage['submit'].toString(),
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (_examMcqController.examQiestion != _examMcqController.examMcqDataModel.data?.totalQuestionCount) {
                                  _examMcqController.examQiestion.value += 1;
                                  _examMcqController.selectedAnswer.value = '';
                                  _examMcqController.examMcqDataApi(widget.examid, widget.studyPlanId);

                                  setState(() {
                                    _start = 122;
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.h / 2),
                                  color: (_examMcqController.examQiestion == _examMcqController.examMcqDataModel.data?.totalQuestionCount)
                                      ? Colors.transparent
                                      : const Color(0XFF503494),
                                ),
                                height: 50.h,
                                margin: EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Text(
                                  mplanguage['next'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: (_examMcqController.examQiestion == _examMcqController.examMcqDataModel.data?.totalQuestionCount)
                                          ? Colors.transparent
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            if (_examMcqController.isloader.value)
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
