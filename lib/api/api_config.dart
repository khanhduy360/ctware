import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  // Server config
  static const domain = 'apidemo.ctn-cantho.com.vn';
  static const urlSite = "https://$domain/api/ctwapi/";

  final BuildContext context;

  const ApiService({required this.context});

  void authSSL(Dio dio) {
    dio.options
      ..baseUrl = urlSite
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);
  }

  Future<Response?> fetchByToken(url) async {
    // Method GET
    try {
      Dio dio = Dio();
      authSSL(dio);
      final response = await dio.get(url,
          options: Options(
            headers: {
              "Authorization": "Bearer ${CacheManage.tokenOnCache}",
              "Accept": "application/json",
            },
          ));
      // ignore: avoid_print
      print('[GET] Result form <$url>:\n$response');
      return response;
    } on DioException catch (error) {
      if(error.response != null) {
        // ignore: avoid_print
        print('[GET] Result form <$url>:\n${error.response}');
        return error.response;
      } else {
        // ignore: avoid_print
        print("[GET] Error form <$url>:\n$error");
        // ignore: use_build_context_synchronously
        ShowingDialog.errorDialog(context, errMes: 'Hệ thống đang lỗi hoặc bảo trì, vui lòng thử lại sau', title: 'Thông báo');
      }
      return null;
    }
  }

  Future<Response?> post(url, data) async {
    // Method POST
    try {
      Dio dio = Dio();
      authSSL(dio);
      final response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json-patch+json",
            },
          ));
      // ignore: avoid_print
      print('[POST] Result form <$url>:\n$response');
      return response;
    } on DioException catch (error) {
      if(error.response != null) {
        // ignore: avoid_print
        print('[POST] Result form <$url>:\n${error.response}');
        return error.response;
      } else {
        // ignore: avoid_print
        print("[POST] Error form <$url>:\n$error");
        // ignore: use_build_context_synchronously
        ShowingDialog.errorDialog(context, errMes: 'Hệ thống đang lỗi hoặc bảo trì, vui lòng thử lại sau', title: 'Thông báo');
      }
      return null;
    }
  }
}
