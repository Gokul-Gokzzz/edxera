import 'dart:io';

import 'package:edxera/category/category_view.dart';
import 'package:edxera/firebase_options.dart';
import 'package:edxera/jobs/job_list_view.dart';
import 'package:edxera/notification/my_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:get/get.dart';
import 'package:edxera/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await MyNotification().initNotification();
  } catch (e) {}

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // runZonedGuarded(() {
  //   //WidgetsFlutterBinding.ensureInitialized();

  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     catchUnhandledExceptions(details.exception, details.stack);
  //   };

  runApp(const MyApp());
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //   if (Platform.isAndroid) {
  //     await FlutterWindowManagerPlus.addFlags(
  //         FlutterWindowManagerPlus.FLAG_SECURE);
  //   }
  // });
//  }, catchUnhandledExceptions);
}

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  // debugPrintStack(stackTrace: stack, label: error.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "edxera learning app",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: DefaultTextStyle(
        maxLines: 3,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        child: Splashscreen(),
      ),
    );
  }
}
