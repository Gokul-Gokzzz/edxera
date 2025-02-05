import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.edxera.wandoor";

  static String isIntro = prefName + "isIntro";
  static String isLogin = prefName + "isLigin";
  static String isCourseName = prefName + "isCourseName";
  static String isCourseId = prefName + "isCourseIds";
  static String userid = prefName + "user_iD";
  static String userPhone = prefName + "user_phone";
  static String device_token = prefName + "device_token";
  static String fcm_token = prefName + "fcm_token";
  static String isVarification = prefName + 'isVarification';
  static String isFirstLogin = prefName + 'isFirstLogin';

  static String languagekey = prefName + "languagekey";

  static setIntro(bool intro) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isIntro, intro);
  }

  static getIntro() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool intro = sharedPreferences.getBool(isIntro) ?? false;
    return intro;
  }

  ///////////////////Ligin Screen////////////////////
  static setLogin(bool login) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isLogin, login);
  }

  static setCourseName(String login) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(isCourseName, login);
  }

  static setCourseID(String login) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(isCourseId, login);
  }

  static getCourseName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String Login = sharedPreferences.getString(isCourseName) ?? '';
    return Login;
  }

  static getCourseId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String Login = sharedPreferences.getString(isCourseId) ?? '';
    return Login;
  }

  static getLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool Login = sharedPreferences.getBool(isLogin) ?? false;
    return Login;
  }

  static setUserId(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(userid, id);
  }

  static getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt(userid) ?? 0;
    return  id;
  }

  static setUserPhone(String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userPhone, phone);
  }

  static getUserPhone() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString(userPhone) ?? "";
    return id;
  }

  static setLanguage(String languagecode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(languagekey, languagecode);
  }

  static getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(languagekey) ?? 'en';
  }

  static setdeviceToken(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(device_token, id);
  }

  static getdeviceToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString(device_token) ?? '';
    return id;
  }

  static setdfcmToken(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(fcm_token, id);
  }

  static getfcmToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString(fcm_token) ?? '';
    return id;
  }

/////////////////////varification/////////
// static setVarification(bool varification) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setBool(isVarification, varification);
// }
//
// static getVarification() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   bool Varification = sharedPreferences.getBool(isVarification) ?? false;
//   return Varification;
// }
// /////////////////////////firstLogin//////////
// static setFirstLogin(bool firstlogin) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setBool(isFirstLogin, firstlogin);
// }
//
// static getFirstLogin() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   bool FirstLogin = sharedPreferences.getBool(isFirstLogin) ?? false;
//   return FirstLogin;
// }
}
