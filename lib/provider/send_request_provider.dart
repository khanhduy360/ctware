import 'package:ctware/model/user_requests.dart';
import 'package:ctware/services/users_service.dart';
import 'package:flutter/material.dart';

class SendRequestProvider extends ChangeNotifier {
  List<UserRequests> userRequestsList = [];

  Future<List<UserRequests>> futureUserRequests(BuildContext context) async {
    final usersService = UsersService(context: context);
    final futureUserRequests = await usersService.getUserRequests();
    userRequestsList = futureUserRequests;
    notifyListeners();
    return futureUserRequests;
  }
}
