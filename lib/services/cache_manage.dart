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
}