import 'dart:io';

import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/bill.dart';
import 'package:ctware/model/contract.dart';
import 'package:ctware/model/pipe_report.dart';
import 'package:ctware/model/user_requests.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/pipe_report/pick_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class UsersService extends ApiService {
  UsersService({required super.context});

  Future<List<Contract>> getContractsApi() async {
    final contractList = <Contract>[];
    final response = await fetchByToken(Url.contracts);
    if (response != null && response.statusCode == 200) {
      for (var value in response.data) {
        contractList.add(Contract.fromJson(value));
      }
    }
    return contractList;
  }

  Future<List<Bill>> getBillsApi() async {
    final billList = <Bill>[];
    final response = await fetchByToken(Url.bills);
    if (response != null && response.statusCode == 200) {
      for (var value in response.data) {
        billList.add(Bill.fromJson(value));
      }
    }
    return billList;
  }

  Future<bool> sendPipeReportApi(String title, String content, List<File> imageData) async {
    // Set up the request data
    String imagePost = '';
    int index = 0;
    int length = imageData.length;
    for(var file in imageData) {
      imagePost += await PickImage.convertToBase64(file);
      index++;
      if(index < length) {
        imagePost += '|';
      }
    }
    DateTime now = DateTime.now();
    String formattedDate = now.toIso8601String();
    final position = await Geolocator.getCurrentPosition();
    Map<String, dynamic> data = {
      "TIEUDE": title,
      "NOIDUNG": content,
      "HINHANH": imagePost,
      "NGAYGUI": formattedDate,
      "IDKH": 0,
      "ACCID": 0,
      "TRANGTHAI": true,
      "X": position.longitude,
      "Y": position.latitude,
      "ProcessingDate": formattedDate,
      "ProcessingContent": "string",
      "Id": 0
    };
    final response = await postByToken(Url.sendPipeReport, data);
    return response != null && response.statusCode == 200;
  }

  Future<List<PipeReport>> getListPipeReport() async {
    final pipeReport = <PipeReport>[];
    final response = await fetchByToken(Url.getListPipeReport);
    if (response != null && response.statusCode == 200) {
      for (var value in response.data) {
          pipeReport.add(PipeReport.fromJson(value));
      }
    }
    return pipeReport;
  }

  Future<List<UserRequests>> getUserRequests() async {
    final userRequests = <UserRequests>[];
    final response = await fetchByToken(Url.userRequests);
    if (response != null && response.statusCode == 200) {
      for (var value in response.data) {
        userRequests.add(UserRequests.fromJson(value));
      }
    }
    return userRequests;
  }

  Future<bool> sendRequestsApi({
    required int reqType,
    required int idkh,
    String? reqContent,
    String? res2Name,
    String? res2Tel,
  }) async {
    DateTime now = DateTime.now();
    String formattedDate = now.toIso8601String();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if(userProvider.user == null) {
      return false;
    }
    Map<String, dynamic> data = {
      "ReqId": 0,
      "AccId": userProvider.user?.accID,
      "Req4MaKv": "string",
      "ReqDate": formattedDate,
      "ReqType": reqType,
      "ReqContent": reqContent,
      "Res2Name": res2Name,
      "Res2Tel": res2Tel,
      "ReqHasResponse": true,
      "ReqHasClosed": true,
      "RequestType": "string",
      "TENKV": "string",
      "IDKH": idkh,
      "TENKH": "string"
    };
    final response = await postByToken(Url.sendRequests, data);
    return response != null && response.statusCode == 200;
  }
}
