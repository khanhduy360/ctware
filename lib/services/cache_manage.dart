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

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Token');
    CacheManage.tokenOnCache = null;
  }

  static setCurrentPass(String currentPass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('CurrentPass', currentPass);
  }

  static Future<String> getCurrenPass() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('CurrentPass').toString();
  }
}
