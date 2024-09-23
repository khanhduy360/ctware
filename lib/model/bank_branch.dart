// ignore_for_file: non_constant_identifier_names, constant_identifier_names
// map to API
class BankBranch {
  int Id;
  String Ten;
  String? MANH;
  String? MAKV;
  String X;
  String Y;
  String? GhiChu;
  String? DiaChi;
  String? DienThoai;
  String? Email;
  String? Website;
  bool TrangThai;

  BankBranch({
    required this.Id,
    required this.Ten,
    required this.MANH,
    required this.MAKV,
    required this.X,
    required this.Y,
    required this.GhiChu,
    required this.DiaChi,
    required this.DienThoai,
    required this.Email,
    required this.Website,
    required this.TrangThai,
  });

  factory BankBranch.fromJson(Map<String, dynamic> responseData) {
    return BankBranch(
      Id: responseData['Id'],
      Ten: responseData['Ten'],
      MANH: responseData['MANH'],
      MAKV: responseData['MAKV'],
      X: responseData['X'],
      Y: responseData['Y'],
      GhiChu: responseData['GhiChu'],
      DiaChi: responseData['DiaChi'],
      DienThoai: responseData['DienThoai'],
      Email: responseData['Email'],
      Website: responseData['Website'],
      TrangThai: responseData['TrangThai'],
    );
  }
}