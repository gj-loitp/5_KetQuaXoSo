import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static String keyThemeIndex = "keyThemeIndex";
  static String keyIsShowedIntroduction = "_keyIsShowedIntroduction";
  static String keyOnOffTextOverflow = "_keyOnOffTextOverflow";
  static String keyOnOffResultVietlotMax3d = "_keyOnOffResultVietlotMax3d";
  static String keyIsShowedDialogHello = "keyIsShowedDialogHello";
  static String keyTooltipTheme = "keyTooltipTheme";
  static String keyTooltipCalendarXSMN = "keyTooltipCalendarXSMN";
  static String keyTooltipCityXSMN = "keyTooltipCityXSMN";
  static String keyTooltipTodayXSMN = "keyTooltipTodayXSMN";
  static int themeIndexNativeView = 0;
  static int themeIndexWebView = 1;
  static String keySearchLeague = "";

  // static bool onOffTextOverflow = false;

  static Future<void> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
