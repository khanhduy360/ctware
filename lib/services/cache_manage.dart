import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheManage {
  static String? tokenOnCache;

  static loadToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var tokenCache = pref.get('Token');
    // ignore: avoid_print
    print('Token: $tokenCache -----------------');
    if (tokenCache != null) {
      CacheManage.tokenOnCache = tokenCache.toString();
    }
  }

  static setToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Token', tokenOnCache ?? '');
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Token');
    CacheManage.tokenOnCache = null;
  }

  static setCurrentPass(String currentPass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('CurrentPass', currentPass);
  }

  static Future<String> getCurrentPass() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('CurrentPass').toString();
  }

  static saveKeywordLogin(String keyword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('KeywordLogin', keyword);
  }

  static Future<String?> loadKeywordLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('KeywordLogin');
  }

  static Future<Map<String, dynamic>?> getSetting() async {
    Map<String, dynamic>? rs;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? settingJs = pref.getString('Setting');
    if(settingJs != null) {
      rs = jsonDecode(settingJs);
    }
    return rs;
  }

  static setSetting(Map<String, dynamic> setting) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(setting);
    pref.setString('Setting', jsonString);
  }
}
