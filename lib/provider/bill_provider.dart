import 'package:ctware/api/url.dart';
import 'package:ctware/configs/utilities.dart';
import 'package:ctware/model/bill.dart';
import 'package:ctware/model/invoice.dart';
import 'package:ctware/model/users.dart';
import 'package:ctware/services/common_service.dart';
import 'package:ctware/services/statistic_service.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:flutter/material.dart';

class BillProvider extends ChangeNotifier {
  List<Bill> listBill = [];
  bool configGCS = false;

  Future<List<Bill>> futureBills(BuildContext context) async {
    final usersService = UsersService(context: context);
    final futureBills = await usersService.getBillsApi();
    listBill = futureBills;
    notifyListeners();
    return futureBills;
  }

  Future<List<Invoice>> futureInvoicesDataChart(
      BuildContext context, idkh) async {
    final statisticService = StatisticService(context: context);
    DateTime now = DateTime.now();
    DateTime oneYearAgo = DateTime(now.year - 1, now.month, now.day);
    DateTime oneYearAgoTest =
        DateTime(oneYearAgo.year - 1, oneYearAgo.month + 1, oneYearAgo.day);
    final futureInvoices = await statisticService.traCuuApi(
        idkh: idkh,
        fromDate: oneYearAgoTest.toUtc().toIso8601String(),
        toDate: oneYearAgo.toUtc().toIso8601String());
    return futureInvoices;
  }

  Future<bool> futureDeleteBill(BuildContext context, Bill bill) async {
    final usersService = UsersService(context: context);
    final rs = await usersService.deleteBillApi(bill.getJson());
    if (rs) {
      final futureBills = await usersService.getBillsApi();
      listBill = futureBills;
      notifyListeners();
    }
    return rs;
  }

  Future<bool> futureAddBill(
    BuildContext context,
    User? user, {
    required String keyword,
    required String secretKey,
  }) async {
    if (user == null) {
      return false;
    }
    Map<String, dynamic> dataGet = {
      "Keyword": keyword,
      "Thang": 0,
      "Nam": 0,
      "Page": 0,
      "Token": "string",
      "IsIncludeName": true,
      "SecretKey": secretKey
    };
    final usersService = UsersService(context: context);
    bool rs = await usersService.getHoaDonApi(dataGet);
    if (rs) {
      Map<String, dynamic> dataAdd = {
        "SODB": "string",
        "TENKH": "string",
        "DIACHI": "string",
        "MAHTTT": "string",
        "MAKV": "string",
        "SODT": "string",
        "SODT_SMS": "string",
        "GHICHU": "string",
        "DONVI": "string",
        "IDKH": keyword,
        "PlatformType": Url.platformType,
        "UserId": user.accID.toString(),
        "PhoneNumber": user.accTel,
        "Email": "string",
        "SharedInfo": user.getJson().toString(),
        "VerifyCustomer": true,
        "VerifyDate": "2024-11-02T06:12:24.511Z",
        "VerifyPhone": user.accTel,
        "UpdateDate": "2024-11-02T06:12:24.511Z",
        "LoginLastTime": "2024-11-02T06:12:24.511Z",
        "Id": 0
      };
      rs = await usersService.addBillApi(dataAdd);
      if (rs) {
        final futureBills = await usersService.getBillsApi();
        listBill = futureBills;
        notifyListeners();
      }
    } else {
      // ignore: use_build_context_synchronously
      ShowingDialog.errorDialog(rootContext,
          errMes: 'Không tìm thấy khách hàng có thông tin này.',
          title: 'Thông báo');
    }
    return rs;
  }

  Future<bool> futureGetConfigGCS(BuildContext context) async {
    final commonService = CommonService(context: context);
    final futureGetConfigGCS = await commonService.getConfigGCS();
    configGCS = futureGetConfigGCS;
    notifyListeners();
    return futureGetConfigGCS;
  }
}
