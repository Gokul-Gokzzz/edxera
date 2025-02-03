import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/controllers/attendence_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';

class AttendenceViewScreen extends StatefulWidget {
  const AttendenceViewScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<AttendenceViewScreen> createState() => _AttendenceViewScreenState();
}

class _AttendenceViewScreenState extends State<AttendenceViewScreen> {
  AttendencePresentController _attendencePresentController = Get.put(AttendencePresentController());
  final EventList<Event> _markedDateMap = EventList<Event>(events: {});
  @override
  void initState() {
    _attendencePresentController.getAttendencePresentAPi(widget.id).then((value) {
      for (var element in _attendencePresentController.getAttendenceDataModel.data?.attendence ?? []) {
        if (element.attendenceType == 'FULL') {
          _markedDateMap.add(
              DateTime.parse(element.date), Event(date: DateTime.parse(element.date), icon: _eventIcon, title: 'Event 1', dot: pressent_student));
        } else if (element.attendenceType == 'HALF') {
          _markedDateMap.add(
            DateTime.parse(element.date),
            Event(date: DateTime.parse(element.date), icon: _eventIcon, title: 'Event 1', dot: late_event),
          );
        } else if (element.attendenceType == 'LEAVE') {
          _markedDateMap.add(
            DateTime.parse(element.date),
            Event(date: DateTime.parse(element.date), icon: _eventIcon, title: 'Event 1', dot: absent_student),
          );
        }
      }
      setState(() {});
    });
    checkLanguage();
    super.initState();
  }

  Map<String, dynamic> mplanguage = new HashMap();

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  // final EventList<Event> _markedDateMap = EventList<Event>(
  //   events: {
  //     DateTime(2023, 12, 6): [
  //       Event(
  //           date: DateTime(2023, 12, 6),
  //           title: 'Event 1',
  //           icon: _eventIcon,
  //           dot: late_event)
  //     ],
  //     DateTime(2023, 12, 1): [
  //       Event(
  //           date: DateTime(2023, 12, 1),
  //           title: 'Event 2',
  //           icon: _eventIcon,
  //           dot: pressent_student),
  //     ],
  //     DateTime(2023, 12, 5): [
  //       Event(
  //           date: DateTime(2023, 12, 5),
  //           title: 'Event 2',
  //           icon: _eventIcon,
  //           dot: absent_student),
  //     ]
  //   },
  // );

  static final Container late_event = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    color: Colors.yellow,
    height: 5.0,
    width: 5.0,
  );

  static final pressent_student = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    color: Colors.green,
    height: 5.0,
    width: 5.0,
  );

  static final absent_student = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    color: Colors.red,
    height: 5.0,
    width: 5.0,
  );

  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: const BorderRadius.all(const Radius.circular(1000)), border: Border.all(color: Colors.blue, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(left: 15.w, top: 20.h),
                  //   child: Text(
                  //     'Nov,2023',
                  //     style: TextStyle(
                  //         fontSize: 17.sp,
                  //         fontFamily: 'Gilroy',
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // Spacer(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      //    Spacer(),
                      GestureDetector(
                        onTap: () {
                          _attendencePresentController.attendencePresentAPi(widget.id).then((value) {
                            _attendencePresentController.getAttendencePresentAPi(widget.id).then((value) {
                              _markedDateMap.clear();
                              for (var element in _attendencePresentController.getAttendenceDataModel.data?.attendence ?? []) {
                                if (element.attendenceType == 'FULL') {
                                  _markedDateMap.add(DateTime.parse(element.date),
                                      Event(date: DateTime.parse(element.date), icon: _eventIcon, title: 'Event 1', dot: pressent_student));
                                } else if (element.attendenceType == 'HALF') {
                                  _markedDateMap.add(
                                    DateTime.parse(element.date),
                                    Event(date: DateTime.parse(element.date), icon: _eventIcon, title: 'Event 1', dot: late_event),
                                  );
                                } else if (element.attendenceType == 'LEAVE') {
                                  _markedDateMap.add(
                                    DateTime.parse(element.date),
                                    Event(date: DateTime.parse(element.date), icon: _eventIcon, title: 'Event 1', dot: absent_student),
                                  );
                                }
                              }
                              setState(() {});
                            });
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h / 2),
                            color: const Color(0XFF503494),
                          ),
                          height: 40.h,
                          width: 250.w,
                          child: Text(
                            mplanguage['presentsnow'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CalendarCarousel<Event>(
                          markedDatesMap: _markedDateMap,
                          // onDayPressed: (DateTime date, List<Event> events) {
                          //   setState(() => _currentDate = date);
                          // },
                          weekendTextStyle: const TextStyle(
                            color: Colors.red,
                          ),
                          thisMonthDayBorderColor: Colors.grey,
                          customDayBuilder: (
                            /// you can provide your own build function to make custom day containers
                            bool isSelectable,
                            int index,
                            bool isSelectedDay,
                            bool isToday,
                            bool isPrevMonthDay,
                            TextStyle textStyle,
                            bool isNextMonthDay,
                            bool isThisMonthDay,
                            DateTime day,
                          ) {
                            return null;
                          },

                          weekFormat: false,
                          height: 450.0,
                          customGridViewPhysics: NeverScrollableScrollPhysics(),
                          todayButtonColor: Colors.black54,
                          // selectedDateTime: _currentDate,
                          // markedDateShowIcon: true,
                          // markedDateIconMaxShown: 1,
                          daysHaveCircularBorder: false,
                        ),
                      ),
                      // Icon(
                      //   Icons.free_cancellation_outlined,
                      //   color: Color(0XFF503494),
                      // ),
                      // Center(
                      //   child: Text(
                      //     'No Attendance data',
                      //     style: TextStyle(
                      //         color: Color(0XFF503494),
                      //         fontSize: 17.sp,
                      //         fontFamily: 'Gilroy',
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  ),
                  // Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 15.w, top: 20.h),
                    child: Text(
                      mplanguage['attendancerecape'].toString(),
                      style: TextStyle(fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Text(
                                mplanguage['full'].toString(),
                                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                (_attendencePresentController.getAttendenceDataModel.data?.present ?? 0).toString(),
                                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Text(
                                mplanguage['half'].toString(),
                                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                (_attendencePresentController.getAttendenceDataModel.data?.late ?? 0).toString(),
                                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Text(
                                mplanguage['leave'].toString(),
                                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                (_attendencePresentController.getAttendenceDataModel.data?.notPresent ?? 0).toString(),
                                style: TextStyle(fontSize: 17.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (_attendencePresentController.isloader.value)
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
