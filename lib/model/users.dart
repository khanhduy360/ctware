// ignore_for_file: non_constant_identifier_names
// map to API
class User {
  int accID;
  int? IDKH;
  String accName;
  String accPass;
  String? accFullName;
  String? accAddress;
  String? accDisplayName;
  String accEmail;
  String accTel;
  int sqID;
  String? Token;
  String? RefreshToken;
  String? SODB;
  String? DisplayName;
  bool accEmailVerified;
  int PlatformType;

  User({
    required this.accID,
    required this.IDKH,
    required this.accName,
    required this.accPass,
    required this.accFullName,
    required this.accAddress,
    required this.accDisplayName,
    required this.accEmail,
    required this.accTel,
    required this.sqID,
    required this.Token,
    required this.RefreshToken,
    required this.SODB,
    required this.DisplayName,
    required this.accEmailVerified,
    required this.PlatformType,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      accID: responseData['accID'],
      IDKH: responseData['IDKH'],
      accName: responseData['accName'],
      accPass: responseData['accPass'],
      accFullName: responseData['accFullName'],
      accAddress: responseData['accAddress'],
      accDisplayName: responseData['accDisplayName'],
      accEmail: responseData['accEmail'],
      accTel: responseData['accTel'],
      sqID: responseData['sqID'],
      Token: responseData['Token'],
      RefreshToken: responseData['RefreshToken'],
      SODB: responseData['SODB'],
      DisplayName: responseData['DisplayName'],
      accEmailVerified: responseData['accEmailVerified'],
      PlatformType: responseData['PlatformType'],
    );
  }

  Map<String, dynamic> getJson() {
    return {
      'accID': accID,
      'IDKH': IDKH,
      'accName': accName,
      'accPass': accPass,
      'accFullName': accFullName,
      'accAddress': accAddress,
      'accDisplayName': accDisplayName,
      'accEmail': accEmail,
      'accTel': accTel,
      'sqID': sqID,
      'Token': Token,
      'RefreshToken': RefreshToken,
      'SODB': SODB,
      'DisplayName': DisplayName,
      'accEmailVerified': accEmailVerified,
      'PlatformType': PlatformType,
    };
  }
}