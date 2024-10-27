// ignore_for_file: non_constant_identifier_names
// map to API

class Bill {
  String? SODB;
  String? TENKH;
  String? DIACHI;
  String? MAHTTT;
  String? MAKV;
  String? SODT;
  String? SODT_SMS;
  String? GHICHU;
  String? DONVI;
  int IDKH;
  int PlatformType;
  String? UserId;
  String PhoneNumber;
  String? Email;
  String? SharedInfo;
  bool VerifyCustomer;
  String? VerifyDate;
  String? VerifyPhone;
  String? UpdateDate;
  String? LoginLastTime;
  int Id;

  Bill({
    this.SODB,
    this.TENKH,
    this.DIACHI,
    this.MAHTTT,
    this.MAKV,
    this.SODT,
    this.SODT_SMS,
    this.GHICHU,
    this.DONVI,
    required this.IDKH,
    required this.PlatformType,
    this.UserId,
    required this.PhoneNumber,
    this.Email,
    this.SharedInfo,
    required this.VerifyCustomer,
    this.VerifyDate,
    this.VerifyPhone,
    this.UpdateDate,
    this.LoginLastTime,
    required this.Id,
  });

  factory Bill.fromJson(Map<String, dynamic> responseData) {
    return Bill(
      SODB: responseData['SODB'],
      TENKH: responseData['TENKH'],
      DIACHI: responseData['DIACHI'],
      MAHTTT: responseData['MAHTTT'],
      MAKV: responseData['MAKV'],
      SODT: responseData['SODT'],
      SODT_SMS: responseData['SODT_SMS'],
      GHICHU: responseData['GHICHU'],
      DONVI: responseData['DONVI'],
      IDKH: responseData['IDKH'],
      PlatformType: responseData['PlatformType'],
      UserId: responseData['UserId'],
      PhoneNumber: responseData['PhoneNumber'],
      Email: responseData['Email'],
      SharedInfo: responseData['SharedInfo'],
      VerifyCustomer: responseData['VerifyCustomer'],
      VerifyDate: responseData['VerifyDate'],
      VerifyPhone: responseData['VerifyPhone'],
      UpdateDate: responseData['UpdateDate'],
      LoginLastTime: responseData['LoginLastTime'],
      Id: responseData['Id'],
    );
  }

  String getSelectItem() {
    return '$IDKH - ${TENKH ?? ''}';
  }

  String getPhoneNumber() {
    if (PhoneNumber.startsWith('84')) {
      return PhoneNumber.replaceFirst('84', '0');
    }
    return PhoneNumber;
  }

  Map<String, dynamic> getJson() {
    return {
      'SODB': SODB,
      'TENKH': TENKH,
      'DIACHI': DIACHI,
      'MAHTTT': MAHTTT,
      'MAKV': MAKV,
      'SODT': SODT,
      'SODT_SMS': SODT_SMS,
      'GHICHU': GHICHU,
      'DONVI': DONVI,
      'IDKH': IDKH,
      'PlatformType': PlatformType,
      'UserId': UserId,
      'PhoneNumber': PhoneNumber,
      'Email': Email,
      'SharedInfo': SharedInfo,
      'VerifyCustomer': VerifyCustomer,
      'VerifyDate': VerifyDate,
      'VerifyPhone': VerifyPhone,
      'UpdateDate': UpdateDate,
      'LoginLastTime': LoginLastTime,
      'Id': Id,
    };
  }
}
