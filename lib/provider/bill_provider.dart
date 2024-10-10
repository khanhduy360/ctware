import 'package:ctware/model/bill.dart';
import 'package:ctware/model/invoice.dart';
import 'package:ctware/services/statistic_service.dart';
import 'package:ctware/services/users_service.dart';
import 'package:flutter/material.dart';

class BillProvider extends ChangeNotifier {
  List<Bill> listBill = [];

  Future<List<Bill>> futureBills(BuildContext context) async {
    final usersService = UsersService(context: context);
    final futureBills = await usersService.getBillsApi();
    listBill = futureBills;
    notifyListeners();
    return futureBills;
  }

  Future<List<Invoice>> futureInvoicesDataChart(BuildContext context, idkh) async {
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
}
