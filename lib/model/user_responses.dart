// ignore_for_file: non_constant_identifier_names
// map to API
import 'package:intl/intl.dart';

class UserResponses {
    int ResId;
    int ReqID;
    String ResDate;
    String? ResMaNv;
    String? ResName;
    String? ResContent;
    bool ResNEW;
    bool ResApproved;
    String? ResApprovedMaNv;
    String? ResApprovedDate;
    bool MyResponse;

  UserResponses({
    required this.ResId,
    required this.ReqID,
    required this.ResDate,
    required this.ResMaNv,
    required this.ResName,
    required this.ResContent,
    required this.ResNEW,
    required this.ResApproved,
    required this.ResApprovedMaNv,
    required this.ResApprovedDate,
    required this.MyResponse,
  });

  factory UserResponses.fromJson(Map<String, dynamic> responseData) {
    return UserResponses(
      ResId: responseData['ResId'],
      ReqID: responseData['ReqID'],
      ResDate: responseData['ResDate'],
      ResMaNv: responseData['ResMaNv'],
      ResName: responseData['ResName'],
      ResContent: responseData['ResContent'],
      ResNEW: responseData['ResNEW'],
      ResApproved: responseData['ResApproved'],
      ResApprovedMaNv: responseData['ResApprovedMaNv'],
      ResApprovedDate: responseData['ResApprovedDate'],
      MyResponse: responseData['MyResponse'],
    );
  }

  String getResDate() {
    final date = DateTime.parse(ResDate);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}