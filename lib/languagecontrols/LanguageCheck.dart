import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LanguageCheck {
  static Future<Map<String, dynamic>> checkLanguage(String code) async {
    Map<String, dynamic> mp = new HashMap();

    if (code.compareTo("en") == 0) {
      mp = await loadJsonFromAssets('assets/locales/en.json');
    } else if (code.compareTo("ml") == 0) {
      mp = await loadJsonFromAssets('assets/locales/ml.json');
    } else if (code.compareTo("hi") == 0) {
      mp = await loadJsonFromAssets('assets/locales/hi.json');
    } else if (code.compareTo("kn") == 0) {
      mp = await loadJsonFromAssets('assets/locales/kn.json');
    }

    return mp;
  }

  static Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
