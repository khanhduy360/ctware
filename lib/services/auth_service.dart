import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/users.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ApiService {
  AuthService({required super.context});

  Future<User?> loginApi({required account, required password}) async {
    // Set up the request data
    Map<String, dynamic> data = {
      "UserName": account,
      "Password": password,
      "Email": "string",
      "InstanceIdService": "string",
      "PlatformType": Url.platformId,
      "Fkey": "string",
    };
    final response = await post(Url.login, data);
    if(response != null && response.statusCode == 200) {
      final user = User.fromJson(response.data);
      CacheManage.tokenOnCache = user.Token;
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('Token', user.Token ?? '');
      // ignore: avoid_print
      print('Token: ${user.Token} ---------------------');
      return user;
    }
    if(response != null && response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      ShowingDialog.errorDialog(context, errMes: response.toString(), title: 'Đăng nhập thất bại');
    }
    return null;
  }

  Future<User?> getUserApi() async {
    Response? response;
    await fetchByToken(Url.getUser).then((value) {
      response = value;
    });
    if (response != null && response?.statusCode == 200) {
      final user = User.fromJson(response?.data);
      return user;
    } else {
      CacheManage.tokenOnCache = null;     
      return null;
    }
  }
}