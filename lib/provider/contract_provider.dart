import 'package:ctware/model/contract.dart';
import 'package:ctware/services/users_service.dart';
import 'package:flutter/material.dart';

class ContractProvider extends ChangeNotifier {
  List<Contract> listContract = [];

  Future<List<Contract>> futureContracts(BuildContext context) async {
    final usersService = UsersService(context: context);
    final futureContracts = await usersService.getContractsApi();
    listContract = futureContracts;
    notifyListeners();
    return futureContracts;
  }
}