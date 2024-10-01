import 'package:ctware/model/bill.dart';
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
}