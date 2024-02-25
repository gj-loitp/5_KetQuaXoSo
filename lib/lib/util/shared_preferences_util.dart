import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesUtil {
  static String ketThemeIndex = "ketThemeIndex";
  static String keyIsShowedDialogHello = "keyIsShowedDialogHello";
  static String keyTooltipTheme = "keyTooltipTheme";
  static String keyTooltipCalendarXSMN = "keyTooltipCalendarXSMN";
  static String keyTooltipCityXSMN = "keyTooltipCityXSMN";
  static String keyTooltipTodayXSMN = "keyTooltipTodayXSMN";
  static int themeIndexNativeView = 0;
  static int themeIndexWebView = 1;

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
}
