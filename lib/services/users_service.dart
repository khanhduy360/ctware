import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/bill.dart';
import 'package:ctware/model/contract.dart';

class UsersService extends ApiService {
  UsersService({required super.context});
  
  Future<List<Contract>> getContractsApi() async {
    final contractList = <Contract>[];
    final response = await fetchByToken(Url.contracts);
    if (response != null && response.statusCode == 200) {
      for(var value in response.data) {
        contractList.add(Contract.fromJson(value));
      }
    }
    return contractList;
  }

  Future<List<Bill>> getBillsApi() async {
    final billList = <Bill>[];
    final response = await fetchByToken(Url.bills);
    if (response != null && response.statusCode == 200) {
      for(var value in response.data) {
        billList.add(Bill.fromJson(value));
      }
    }
    return billList;
  }
}