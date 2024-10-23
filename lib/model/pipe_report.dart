// ignore_for_file: non_constant_identifier_names
// map to API
import 'package:intl/intl.dart';

class PipeReport {
  String TIEUDE;
  String NOIDUNG;
  String? HINHANH;
  String NGAYGUI;
  int IDKH;
  int ACCID;
  bool TRANGTHAI;
  double? X;
  double? Y;
  String ProcessingDate;
  String? ProcessingContent;
  int Id;

  PipeReport({
    required this.TIEUDE,
    required this.NOIDUNG,
    required this.HINHANH,
    required this.NGAYGUI,
    required this.IDKH,
    required this.ACCID,
    required this.TRANGTHAI,
    required this.X,
    required this.Y,
    required this.ProcessingDate,
    required this.ProcessingContent,
    required this.Id,
  });

  factory PipeReport.fromJson(Map<String, dynamic> responseData) {
    return PipeReport(
      TIEUDE: responseData['TIEUDE'],
      NOIDUNG: responseData['NOIDUNG'],
      HINHANH: responseData['HINHANH'],
      NGAYGUI: responseData['NGAYGUI'],
      IDKH: responseData['IDKH'],
      ACCID: responseData['ACCID'],
      TRANGTHAI: responseData['TRANGTHAI'],
      X: responseData['X'],
      Y: responseData['Y'],
      ProcessingDate: responseData['ProcessingDate'],
      ProcessingContent: responseData['ProcessingContent'],
      Id: responseData['Id'],
    );
  }

  String getNGAYGUI() {
    final date = DateTime.parse(NGAYGUI);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}
