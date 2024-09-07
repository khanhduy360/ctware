import 'package:ctware/model/users.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  void setUser(User? user) {
    user = user;
    notifyListeners();
  }
}