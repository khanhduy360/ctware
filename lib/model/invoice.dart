// ignore_for_file: non_constant_identifier_names
// map to API

import 'package:intl/intl.dart';

class Invoice {
  int IDKH;
  int NAM;
  int THANG;
  int STT;
  String? SOPHIEU;
  String? MAKV;
  String? MAQUAN;
  String? MAPHUONG;
  String? MADP;
  String? DUONGPHU;
  String? MALKHDB;
  String? MADB;
  String? SODB;
  String? HOTEN;
  String? DIACHI;
  String? DIACHI_KH;
  String? MST;
  int SONK;
  int CSCU;
  int CSMOI;
  int M3TT;
  String? M3TT1;
  String? M3TT2;
  String? M3TT3;
  String? MALKHDBTUNGKHOANG;
  String? DONGIATUNGKHOANG;
  String? M3TTTUNGKHOAN;
  String? THANHTIENTUNGKHOANG;
  double CONGTHANHTIEN;
  int VAT;
  double TIENVAT;
  int TIENLUUBO;
  int PBVMT4M3;
  int TIENPBVMT;
  int PNT4M3;
  int TIENPNT;
  int TONGCONG;
  int TTGHI;
  String? MAHTTT;
  String? MAHTTT_HT;
  bool HETNO;
  String? NGAYCN;
  DateTime? NGAYNHAPCN;
  String? HDDT_MAUSO;
  String? HDDT_KYHIEU;
  String? GHICHU;
  String? KYHOADON;
  String? TRANGTHAITHANHTOAN;
  String? TRANGTHAI;
  int TRANGTHAIHOADON;
  String? KHUVUC;
  String? SERIALSOHD;
  bool HasBill;
  String? ActionUrl;
  String? KYHD;
  String? MAPHATHANH;
  int PHHOADON;
  int TONGKYNO;
  int TONGTIENNO;
  String? TTDIEUCHINH;
  String NGAYPHHD;
  String? NGAYDIEUCHINH;
  String? NVDIEUCHINH;
  String? cashMANH;
  String? KEYPHHOADON;
  int? GNHOADON;
  String? NGAYGNHOADON;
  String? TTPHDIEUCHINH;
  String? NGAYPHDIEUCHINH;
  String? GIAMGIA;
  bool TINHPBVMT_PHANTRAM;
  bool TINHPBVMT_RUNG;
  int PBVMT_RUNG;
  int TIENPBVMT_RUNG;
  bool TINHNHANKHAU;
  bool NONGTHON;
  bool LOCKGCS;
  bool LOCKTINHCUOC;

  Invoice({
    required this.IDKH,
    required this.NAM,
    required this.THANG,
    required this.STT,
    required this.SOPHIEU,
    required this.MAKV,
    required this.MAQUAN,
    required this.MAPHUONG,
    required this.MADP,
    required this.DUONGPHU,
    required this.MALKHDB,
    required this.MADB,
    required this.SODB,
    required this.HOTEN,
    required this.DIACHI,
    required this.DIACHI_KH,
    required this.MST,
    required this.SONK,
    required this.CSCU,
    required this.CSMOI,
    required this.M3TT,
    required this.M3TT1,
    required this.M3TT2,
    required this.M3TT3,
    required this.MALKHDBTUNGKHOANG,
    required this.DONGIATUNGKHOANG,
    required this.M3TTTUNGKHOAN,
    required this.THANHTIENTUNGKHOANG,
    required this.CONGTHANHTIEN,
    required this.VAT,
    required this.TIENVAT,
    required this.TIENLUUBO,
    required this.PBVMT4M3,
    required this.TIENPBVMT,
    required this.PNT4M3,
    required this.TIENPNT,
    required this.TONGCONG,
    required this.TTGHI,
    required this.MAHTTT,
    required this.MAHTTT_HT,
    required this.HETNO,
    required this.NGAYCN,
    required this.NGAYNHAPCN,
    required this.HDDT_MAUSO,
    required this.HDDT_KYHIEU,
    required this.GHICHU,
    required this.KYHOADON,
    required this.TRANGTHAITHANHTOAN,
    required this.TRANGTHAI,
    required this.TRANGTHAIHOADON,
    required this.KHUVUC,
    required this.SERIALSOHD,
    required this.HasBill,
    required this.ActionUrl,
    required this.KYHD,
    required this.MAPHATHANH,
    required this.PHHOADON,
    required this.TONGKYNO,
    required this.TONGTIENNO,
    required this.TTDIEUCHINH,
    required this.NGAYPHHD,
    required this.NGAYDIEUCHINH,
    required this.NVDIEUCHINH,
    required this.cashMANH,
    required this.KEYPHHOADON,
    required this.GNHOADON,
    required this.NGAYGNHOADON,
    required this.TTPHDIEUCHINH,
    required this.NGAYPHDIEUCHINH,
    required this.GIAMGIA,
    required this.TINHPBVMT_PHANTRAM,
    required this.TINHPBVMT_RUNG,
    required this.PBVMT_RUNG,
    required this.TIENPBVMT_RUNG,
    required this.TINHNHANKHAU,
    required this.NONGTHON,
    required this.LOCKGCS,
    required this.LOCKTINHCUOC,
  });

  factory Invoice.fromJson(Map<String, dynamic> responseData) {
    return Invoice(
      IDKH: responseData['IDKH'],
      NAM: responseData['NAM'],
      THANG: responseData['THANG'],
      STT: responseData['STT'],
      SOPHIEU: responseData['SOPHIEU'],
      MAKV: responseData['MAKV'],
      MAQUAN: responseData['MAQUAN'],
      MAPHUONG: responseData['MAPHUONG'],
      MADP: responseData['MADP'],
      DUONGPHU: responseData['DUONGPHU'],
      MALKHDB: responseData['MALKHDB'],
      MADB: responseData['MADB'],
      SODB: responseData['SODB'],
      HOTEN: responseData['HOTEN'],
      DIACHI: responseData['DIACHI'],
      DIACHI_KH: responseData['DIACHI_KH'],
      MST: responseData['MST'],
      SONK: responseData['SONK'],
      CSCU: responseData['CSCU'],
      CSMOI: responseData['CSMOI'],
      M3TT: responseData['M3TT'],
      M3TT1: responseData['M3TT1'],
      M3TT2: responseData['M3TT2'],
      M3TT3: responseData['M3TT3'],
      MALKHDBTUNGKHOANG: responseData['MALKHDBTUNGKHOANG'],
      DONGIATUNGKHOANG: responseData['DONGIATUNGKHOANG'],
      M3TTTUNGKHOAN: responseData['M3TTTUNGKHOAN'],
      THANHTIENTUNGKHOANG: responseData['THANHTIENTUNGKHOANG'],
      CONGTHANHTIEN: responseData['CONGTHANHTIEN'],
      VAT: responseData['VAT'],
      TIENVAT: responseData['TIENVAT'],
      TIENLUUBO: responseData['TIENLUUBO'],
      PBVMT4M3: responseData['PBVMT4M3'],
      TIENPBVMT: responseData['TIENPBVMT'],
      PNT4M3: responseData['PNT4M3'],
      TIENPNT: responseData['TIENPNT'],
      TONGCONG: responseData['TONGCONG'],
      TTGHI: responseData['TTGHI'],
      MAHTTT: responseData['MAHTTT'],
      MAHTTT_HT: responseData['MAHTTT_HT'],
      HETNO: responseData['HETNO'],
      NGAYCN: responseData['NGAYCN'],
      NGAYNHAPCN: responseData['NGAYNHAPCN'],
      HDDT_MAUSO: responseData['HDDT_MAUSO'],
      HDDT_KYHIEU: responseData['HDDT_KYHIEU'],
      GHICHU: responseData['GHICHU'],
      KYHOADON: responseData['KYHOADON'],
      TRANGTHAITHANHTOAN: responseData['TRANGTHAITHANHTOAN'],
      TRANGTHAI: responseData['TRANGTHAI'],
      TRANGTHAIHOADON: responseData['TRANGTHAIHOADON'],
      KHUVUC: responseData['KHUVUC'],
      SERIALSOHD: responseData['SERIALSOHD'],
      HasBill: responseData['HasBill'],
      ActionUrl: responseData['ActionUrl'],
      KYHD: responseData['KYHD'],
      MAPHATHANH: responseData['MAPHATHANH'],
      PHHOADON: responseData['PHHOADON'],
      TONGKYNO: responseData['TONGKYNO'],
      TONGTIENNO: responseData['TONGTIENNO'],
      TTDIEUCHINH: responseData['TTDIEUCHINH'],
      NGAYPHHD: responseData['NGAYPHHD'],
      NGAYDIEUCHINH: responseData['NGAYDIEUCHINH'],
      NVDIEUCHINH: responseData['NVDIEUCHINH'],
      cashMANH: responseData['cashMANH'],
      KEYPHHOADON: responseData['KEYPHHOADON'],
      GNHOADON: responseData['GNHOADON'],
      NGAYGNHOADON: responseData['NGAYGNHOADON'],
      TTPHDIEUCHINH: responseData['TTPHDIEUCHINH'],
      NGAYPHDIEUCHINH: responseData['NGAYPHDIEUCHINH'],
      GIAMGIA: responseData['GIAMGIA'],
      TINHPBVMT_PHANTRAM: responseData['TINHPBVMT_PHANTRAM'],
      TINHPBVMT_RUNG: responseData['TINHPBVMT_RUNG'],
      PBVMT_RUNG: responseData['PBVMT_RUNG'],
      TIENPBVMT_RUNG: responseData['TIENPBVMT_RUNG'],
      TINHNHANKHAU: responseData['TINHNHANKHAU'],
      NONGTHON: responseData['NONGTHON'],
      LOCKGCS: responseData['LOCKGCS'],
      LOCKTINHCUOC: responseData['LOCKTINHCUOC'],
    );
  }

  String getTongTien() {
    return NumberFormat('#,###').format(TONGCONG).replaceAll(',', '.');
  }

  String getNPHHD() {
    final date = DateTime.parse(NGAYPHHD);
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
