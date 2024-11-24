import 'dart:convert';

import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/users.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:dio/dio.dart';

class AuthService extends ApiService {
  AuthService({required super.context});

  Future<User?> loginApi(
      {required account, required password, bool localAuth = false}) async {
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
    if (response != null && response.statusCode == 200) {
      final user = User.fromJson(response.data);
      CacheManage.tokenOnCache = user.Token;
      CacheManage.setToken();
      CacheManage.saveKeywordLogin(data['UserName']);
      CacheManage.setCurrentPass(data['Password']);
      // ignore: avoid_print
      print('Token: ${user.Token} ---------------------');
      return user;
    }
    if (!localAuth) {
      if (response != null && response.statusCode == 400) {
        // ignore: use_build_context_synchronously
        ShowingDialog.errorDialog(context,
            errMes: response.toString(), title: 'Đăng nhập thất bại');
      }
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

  Future<User?> updateUser(User? user) async {
    final data = jsonEncode({
      'accID': user?.accID,
      'IDKH': user?.IDKH,
      'accName': user?.accName,
      'accPass': user?.accPass,
      'accFullName': user?.accFullName,
      'accAddress': user?.accAddress,
      'accDisplayName': user?.accDisplayName,
      'accEmail': user?.accEmail,
      'accTel': user?.accTel,
      'sqID': user?.sqID,
      'Token': user?.Token,
      'RefreshToken': user?.RefreshToken,
      'SODB': user?.SODB,
      'DisplayName': user?.DisplayName,
      'accEmailVerified': user?.accEmailVerified,
      'PlatformType': user?.PlatformType,
    });
    final response = await postByToken(Url.updateUser, data);
    if (response != null && response.statusCode == 200) {
      final user = User.fromJson(response.data);
      // ignore: use_build_context_synchronously
      ShowingDialog.successDialog(context,
          message: 'Cập nhật thành công', title: 'Cập nhật');
      return user;
    }
    if (response != null && response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      ShowingDialog.errorDialog(context,
          errMes: response.toString(), title: 'Cập nhật thất bại');
    }
    return null;
  }

  Future<bool> changePassword(
      {required String password, required String newPassword}) async {
    final data = {
      'Password': password,
      'NewPassword': newPassword,
      'PlatformType': Url.platformId,
    };
    final response = await postByToken(Url.changePassword, data);
    if (response != null && response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      CacheManage.setCurrentPass(newPassword);
      return true;
    }
    if (response != null && response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      ShowingDialog.errorDialog(context,
          errMes: response.toString(), title: 'Đổi mật khẩu thất bại');
    }
    return false;
  }
}
