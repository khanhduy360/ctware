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
    final responseHetNo = await post(Url.traCuu, dataPostHetNo);
    if(responseHetNo != null && responseHetNo.statusCode == 200) {
      
    }
    final responseConNo = await post(Url.traCuu, dataPostConNo);
    if(responseConNo != null && responseConNo.statusCode == 200) {
      
    }
    return listInvoice;
  }
}