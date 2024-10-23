import 'package:ctware/model/request_types.dart';
import 'package:ctware/services/common_service.dart';
import 'package:flutter/material.dart';

class RequestTypesProvider extends ChangeNotifier {
  List<RequestTypes> listRequestTypes = [];

  Future<List<RequestTypes>> futureRequestTypes(BuildContext context) async {
    CommonService commonService = CommonService(context: context);
    final futureRequestTypes = await commonService.getRequestTypes();
    listRequestTypes = futureRequestTypes;
    notifyListeners();
    return futureRequestTypes;
  }
}
