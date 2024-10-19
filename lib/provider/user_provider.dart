import 'package:ctware/model/users.dart';
import 'package:ctware/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  void setUser(User? userParam) {
    user = userParam;
    notifyListeners();
  }

  bool isEmailVerified() {
    return user == null ? false : user!.accEmailVerified;
  }

  String? getFullName() {
    if (user == null && user?.accFullName == null ||
        user?.accFullName?.isEmpty == true) {
      return null;
    }
    return user?.accFullName;
  }

  String? getTel() {
    if (user == null && user?.accTel == null || user?.accTel.isEmpty == true) {
      return null;
    }
    return user?.accTel;
  }

  String? getEmail() {
    if (user == null && user?.accEmail == null ||
        user?.accEmail.isEmpty == true) {
      return null;
    }
    return user?.accEmail;
  }

  String? getUsername() {
    if (user == null && user?.accName == null ||
        user?.accName.isEmpty == true) {
      return null;
    }
    return user?.accName;
  }

  String? getAddress() {
    if (user == null ||
        user?.accAddress == null ||
        user?.accAddress?.isEmpty == true) {
      return null;
    }
    return user?.accAddress;
  }

  String? getDisplayName() {
    if (user == null ||
        user?.accDisplayName == null ||
        user?.accDisplayName?.isEmpty == true) {
      return null;
    }
    return user?.accDisplayName;
  }

  void setDisplayName(String displayName) {
    user?.accDisplayName = displayName;
  }

  void setAddress(String address) {
    user?.accAddress = address;
  }

  void setFullName(String fullName) {
    user?.accFullName = fullName;
  }

  Future<User?> updateUser(BuildContext context) async {
    final authService = AuthService(context: context);
    final response = authService.updateUser(user);
    notifyListeners();

    return response;
  }
}
