// ignore_for_file: non_constant_identifier_names, constant_identifier_names
// map to API
class AdvertiseSlide {
  int ID;
  String? TIEUDE;
  String? LINK;
  String? HINHANH;
  int THUTU;
  String? MIMETYPE;
  bool TRANGTHAI;
  DateTime? UpdateTime;
  int Id;

  AdvertiseSlide({
    required this.ID,
    required this.TIEUDE,
    required this.LINK,
    required this.HINHANH,
    required this.THUTU,
    required this.MIMETYPE,
    required this.TRANGTHAI,
    required this.UpdateTime,
    required this.Id,
  });

  factory AdvertiseSlide.fromJson(Map<String, dynamic> responseData) {
    return AdvertiseSlide(
      ID: responseData['ID'],
      TIEUDE: responseData['TIEUDE'],
      LINK: responseData['LINK'],
      HINHANH: responseData['HINHANH'],
      THUTU: responseData['THUTU'],
      MIMETYPE: responseData['MIMETYPE'],
      TRANGTHAI: responseData['TRANGTHAI'],
      UpdateTime: responseData['UpdateTime'],
      Id: responseData['Id'],
    );
  }
}