import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';
import '../../Models/announcements_entity.dart';
import '../../controllers/announcementcontroller.dart';

class AnnouncementsView extends StatefulWidget {
  String batchid;

  AnnouncementsView(this.batchid);

  @override
  _AnnouncementsViewState createState() => _AnnouncementsViewState(this.batchid);
}

class _AnnouncementsViewState extends State<AnnouncementsView> {
  String batchid;
  _AnnouncementsViewState(this.batchid);

  AnouncementController _announcementcontroller = Get.put(AnouncementController());

  @override
  void initState() {
    // TODO: implement initState
    _announcementcontroller.getAnnouncementData(batchid);
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
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              (_announcementcontroller.batchAnnouncementDataModel.data.batchAnnouncements.length > 0)
                  ? Align(
                      alignment: FractionalOffset.topCenter,
                      child: ListView.builder(
                          itemCount: _announcementcontroller.batchAnnouncementDataModel.data.batchAnnouncements.length,
                          itemBuilder: (BuildContext context, int index) {
                            AnnouncementsDataBatchAnnouncements abc =
                                _announcementcontroller.batchAnnouncementDataModel.data.batchAnnouncements[index];

                            return ListTile(
                              leading: Icon(
                                Icons.announcement,
                                size: 25,
                              ),
                              // trailing: const Text(
                              //   "GFG",
                              //   style: TextStyle(color: Colors.green, fontSize: 15),
                              // ),
                              title: Text(abc.title, style: TextStyle(fontSize: 14, color: Colors.black)),
                              subtitle: Text(abc.announcementDate, style: TextStyle(fontSize: 12, color: Colors.black)),
                            );
                          }),
                    )
                  : Align(
                      alignment: FractionalOffset.center,
                      child: Text(
                        mplanguage['nodata'].toString(),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    )
            ],
          )),
    );
  }
}
