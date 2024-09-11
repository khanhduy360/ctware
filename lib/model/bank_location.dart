// ignore_for_file: non_constant_identifier_names, constant_identifier_names
// map to API
import 'package:ctware/model/bank_branch.dart';

class BankLocation {
  String MANH;
  String TENNH;
  List<BankBranch> NganHangDiaDiems;

  // Main branch
  static const MAIN_BRANCH = 'CTW';

  BankLocation({
    required this.MANH,
    required this.TENNH,
    required this.NganHangDiaDiems,
  });

  factory BankLocation.fromJson(Map<String, dynamic> responseData) {
    List<BankBranch> NganHangDiaDiems = <BankBranch>[];
    for(var bankBranch in responseData['NganHangDiaDiems']) {
      NganHangDiaDiems.add(BankBranch.fromJson(bankBranch));
    }
    return BankLocation(
      MANH: responseData['MANH'],
      TENNH: responseData['TENNH'],
      NganHangDiaDiems: NganHangDiaDiems
    );
  }
}