// ignore_for_file: non_constant_identifier_names
// map to API
import 'package:intl/intl.dart';

class UserRequests {
    int ReqId;
    int AccId;
    String? Req4MaKv;
    String ReqDate;
    int ReqType;
    String? ReqContent;
    String? Res2Name;
    String? Res2Tel;
    bool ReqHasResponse;
    bool ReqHasClosed;
    String? RequestType;
    bool CanSendRequest;
    String? TENKV;
    int IDKH;
    String? TENKH;

  UserRequests({
    required this.ReqId,
    required this.AccId,
    required this.Req4MaKv,
    required this.ReqDate,
    required this.ReqType,
    required this.ReqContent,
    required this.Res2Name,
    required this.Res2Tel,
    required this.ReqHasResponse,
    required this.ReqHasClosed,
    required this.RequestType,
    required this.CanSendRequest,
    required this.TENKV,
    required this.IDKH,
    required this.TENKH,
  });

  factory UserRequests.fromJson(Map<String, dynamic> responseData) {
    return UserRequests(
      ReqId: responseData['ReqId'],
      AccId: responseData['AccId'],
      Req4MaKv: responseData['Req4MaKv'],
      ReqDate: responseData['ReqDate'],
      ReqType: responseData['ReqType'],
      ReqContent: responseData['ReqContent'],
      Res2Name: responseData['Res2Name'],
      Res2Tel: responseData['Res2Tel'],
      ReqHasResponse: responseData['ReqHasResponse'],
      ReqHasClosed: responseData['ReqHasClosed'],
      RequestType: responseData['RequestType'],
      CanSendRequest: responseData['CanSendRequest'],
      TENKV: responseData['TENKV'],
      IDKH: responseData['IDKH'],
      TENKH: responseData['TENKH'],
    );
  }

  String getReqDate() {
    final date = DateTime.parse(ReqDate);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}