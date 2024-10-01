// ignore_for_file: file_names

import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/invoice.dart';

class StatisticService extends ApiService {
  StatisticService({required super.context});
  
  Future<List<Invoice>> traCuuApi({required idkh, required fromDate, required toDate}) async {
    // Set up the request data
    Map<String, dynamic> dataPostHetNo = {
      "IdKh": idkh,
      "FromDate": fromDate,
      "ToDate": toDate,
      "IsHetNo": true,
    };
    Map<String, dynamic> dataPostConNo = {
      "IdKh": idkh,
      "FromDate": fromDate,
      "ToDate": toDate,
      "IsHetNo": false,
    };
    final listInvoice = <Invoice>[];
    final responseHetNo = await postByToken(Url.traCuu, dataPostHetNo);
    if(responseHetNo != null && responseHetNo.statusCode == 200) {
      for(var value in responseHetNo.data) {
        listInvoice.add(Invoice.fromJson(value));
      }
    }
    final responseConNo = await postByToken(Url.traCuu, dataPostConNo);
    if(responseConNo != null && responseConNo.statusCode == 200) {
      for(var value in responseConNo.data) {
        listInvoice.add(Invoice.fromJson(value));
      }
    }
    listInvoice.sort((a, b) {
      if(a.NGAYPHHD == null && b.NGAYPHHD == null) {
        return 0;
      }
      if(a.NGAYPHHD == null) {
        return -1;
      } else if(b.NGAYPHHD == null) {
        return 1;
      }
      final dateA = DateTime.parse(a.NGAYPHHD!);
      final dateB = DateTime.parse(b.NGAYPHHD!);
      return dateB.compareTo(dateA);
    });
    return listInvoice;
  }
}