// ignore_for_file: non_constant_identifier_names, constant_identifier_names
// map to API
import 'package:ctware/model/bank_branch.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    for (var bankBranch in responseData['NganHangDiaDiems']) {
      NganHangDiaDiems.add(BankBranch.fromJson(bankBranch));
    }
    return BankLocation(
        MANH: responseData['MANH'],
        TENNH: responseData['TENNH'],
        NganHangDiaDiems: NganHangDiaDiems);
  }

  LatLng getFirstPosition() {
    BankBranch activeBranchFirst = NganHangDiaDiems.first;
    for (var branch in NganHangDiaDiems) {
      if (branch.TrangThai) {
        activeBranchFirst = branch;
        break;
      }
    }
    return activeBranchFirst.getPosition();
  }

  Future<Map<String, Marker>> getMarKerList() async {
    Map<String, Marker> markerList = {};
    final markerIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(40, 40)), 'assets/icons/cusmarker.png');
    for (var branch in NganHangDiaDiems) {
      if (branch.TrangThai) {
        markerList[branch.Id.toString()] = Marker(
            markerId: MarkerId(branch.Id.toString()),
            position: LatLng(double.parse(branch.X), double.parse(branch.Y)),
            infoWindow: InfoWindow(
              title: branch.Ten,
              snippet: branch.DiaChi,
            ),
            icon: markerIcon);
      }
    }
    return markerList;
  }
}
