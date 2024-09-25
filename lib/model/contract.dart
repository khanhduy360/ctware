// ignore_for_file: non_constant_identifier_names
// map to API

class Contract {
  int ID;
  int IDKH;
  String? SODB;
  String? HOTEN;
  String? DIACHI;
  String? EMAIL;
  String? DIENTHOAI;
  String? MAKV;
  String? IDHOPDONG;
  String? MAHOPDONG;
  String? SOHOPDONG;
  String? TENHOPDONG;
  String? THOIGIANTAO;
  String? NGAYCAPNHAT;
  String? NGUOICAPNHAT;
  String? NGAYKY_KHACHHANG;
  String? NGAYKY_CONGTY;
  String? KEYWORD;
  String? THOIGIANTAO_FORMATTED;
  String? TENKV;
  String? UserId;
  int PlatformType;

  Contract({
    required this.ID,
    required this.IDKH,
    required this.SODB,
    required this.HOTEN,
    required this.DIACHI,
    required this.EMAIL,
    required this.DIENTHOAI,
    required this.MAKV,
    required this.IDHOPDONG,
    required this.MAHOPDONG,
    required this.SOHOPDONG,
    required this.TENHOPDONG,
    required this.THOIGIANTAO,
    required this.NGAYCAPNHAT,
    required this.NGUOICAPNHAT,
    required this.NGAYKY_KHACHHANG,
    required this.NGAYKY_CONGTY,
    required this.KEYWORD,
    required this.THOIGIANTAO_FORMATTED,
    required this.TENKV,
    required this.UserId,
    required this.PlatformType,
  });

  factory Contract.fromJson(Map<String, dynamic> responseData) {
    return Contract(
      ID: responseData['ID'],
      IDKH: responseData['IDKH'],
      SODB: responseData['SODB'],
      HOTEN: responseData['HOTEN'],
      DIACHI: responseData['DIACHI'],
      EMAIL: responseData['EMAIL'],
      DIENTHOAI: responseData['DIENTHOAI'],
      MAKV: responseData['MAKV'],
      IDHOPDONG: responseData['IDHOPDONG'],
      MAHOPDONG: responseData['MAHOPDONG'],
      SOHOPDONG: responseData['SOHOPDONG'],
      TENHOPDONG: responseData['TENHOPDONG'],
      THOIGIANTAO: responseData['THOIGIANTAO'],
      NGAYCAPNHAT: responseData['NGAYCAPNHAT'],
      NGUOICAPNHAT: responseData['NGUOICAPNHAT'],
      NGAYKY_KHACHHANG: responseData['NGAYKY_KHACHHANG'],
      NGAYKY_CONGTY: responseData['NGAYKY_CONGTY'],
      KEYWORD: responseData['KEYWORD'],
      THOIGIANTAO_FORMATTED: responseData['THOIGIANTAO_FORMATTED'],
      TENKV: responseData['TENKV'],
      UserId: responseData['UserId'],
      PlatformType: responseData['PlatformType'],
    );
  }
}