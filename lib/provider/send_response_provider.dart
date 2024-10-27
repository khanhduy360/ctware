import 'package:ctware/model/user_responses.dart';
import 'package:ctware/services/users_service.dart';
import 'package:flutter/material.dart';

class SendResponseProvider extends ChangeNotifier {
  List<UserResponses> userResponsesList = [];

  Future<List<UserResponses>> futureUserResponses(BuildContext context, int reqId) async {
    final usersService = UsersService(context: context);
    final futureUserResponses = await usersService.getResponses(reqId);
    userResponsesList = futureUserResponses;
    notifyListeners();
    return futureUserResponses;
  }

  Future<bool> futureSendResponses(BuildContext context, {
    required int reqID,
    required String resContent,
  }) async {
    final usersService = UsersService(context: context);
    DateTime now = DateTime.now();
    String formattedDate = now.toIso8601String();
    Map<String, dynamic> data = {
      "ResId": 0,
      "ReqID": reqID,
      "ResDate": formattedDate,
      "ResMaNv": "string",
      "ResName": "string",
      "ResContent": resContent,
      "ResNEW": true,
      "ResApproved": true,
      "ResApprovedMaNv": "string",
      "ResApprovedDate": formattedDate
    };
    final rs = await usersService.sendResponseApi(data);
    if(rs) {
      final futureUserResponses = await usersService.getResponses(reqID);
      userResponsesList = futureUserResponses;
      notifyListeners();
    }
    return rs;
  }
}
