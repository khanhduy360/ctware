import 'package:ctware/model/contract.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:flutter/material.dart';

class ContractProvider extends ChangeNotifier {
  List<Contract> listContract = [];

  Future<List<Contract>> futureContracts(BuildContext context) async {
    final usersService = UsersService(context: context);
    final futureContracts = await usersService.getContractsApi();
    listContract = futureContracts;
    notifyListeners();
    if(listContract.isEmpty) {
      // ignore: use_build_context_synchronously
      ShowingDialog.errorDialog(context, errMes: 'Không tìm thấy hợp đồng', title: 'Thông báo');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
    return futureContracts;
  }
}