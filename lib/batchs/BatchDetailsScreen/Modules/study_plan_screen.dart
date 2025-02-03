import 'package:edxera/utils/screen_size.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudyPlanScreen extends StatefulWidget {
  const StudyPlanScreen({super.key});

  @override
  State<StudyPlanScreen> createState() => _StudyPlanScreenState();
}

class _StudyPlanScreenState extends State<StudyPlanScreen> {
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
          "Study Plan",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    ExpansionTileCard(
                      trailing: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Image.asset("assets/down.png", height: 24.h, width: 24.w),
                      ),
                      animateTrailing: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                      borderRadius: BorderRadius.circular(22.h),
                      leading: Image.asset(
                        'assets/lesson1.png',
                        height: 66.h,
                        width: 66.w,
                      ),
                      title: Text(
                        'Kerala PSC HSST',
                        style: TextStyle(fontSize: 14.sp, color: Color(0XFF000000), fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                            child: Stack(
                              children: [
                                Container(
                                  height: 70.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(70.h / 2),
                                  ),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/gridview1.png',
                                        color: Colors.white,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(100.h / 2),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 20,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'LIVE',
                                          style: TextStyle(fontSize: 12.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 70.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(70.h / 2),
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/gridview1.png',
                                color: Colors.white,
                              ),
                            ),
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(100.h / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 20,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'LIVE',
                                  style: TextStyle(fontSize: 12.sp, color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "HSST CS GOLD 23".toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                height: 20.h,
                                child: Text(
                                  "DAY",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    "15",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Today's lessons",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.blue,
                              size: 40,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Theory of Computation-01",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
                            ),
                            Text(
                              "30:40 min",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.blue,
                              size: 40,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Theory of Computation-02",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
                            ),
                            Text(
                              "20:40 min",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.assignment,
                              color: Colors.orange,
                              size: 40,
                            )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Theory of Computation-01,02-2023-12-03",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
                              ),
                              Text(
                                "20:40 min",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
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
                  borderRadius: BorderRadius.circular(50.h / 2),
                  color: const Color(0XFF503494),
                ),
                height: 50.h,
                margin: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Text(
                  "View Study Plan",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
