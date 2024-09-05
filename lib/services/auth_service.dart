import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/users.dart';

class AuthService extends ApiService {
  AuthService({required super.context});

  Future<User?> loginApi({required account, required password}) async {
    // Set up the request data
    Map<String, dynamic> data = {
      "UserName": account,
      "Password": password,
      "Email": "string",
      "InstanceIdService": "string",
      "PlatformType": 3,
      "Fkey": "string",
    };
    final response = await post(loginUrl, data);
    if(response != null && response.statusCode == 200) {
      return User.fromJson(response.data);
    }
    if(response != null && response.statusCode == 400) {
      print('Mai lam');
    }
    return null;
  }
}