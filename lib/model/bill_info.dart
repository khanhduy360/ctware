// ignore_for_file: non_constant_identifier_names
// map to API

class BillInfo {
  int IDKH;
  int NAM;
  int THANG;
  int STT;
  dynamic SOPHIEU;
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
  int? SONK;
  int CSCU;
  int CSMOI;
  int M3TT;
  int M3TT1;
  int M3TT2;
  int M3TT3;
  String? MALKHDBTUNGKHOANG;
  String? DONGIATUNGKHOANG;
  String? M3TTTUNGKHOAN;
  String? THANHTIENTUNGKHOANG;
  dynamic CONGTHANHTIEN;
  int VAT;
  double TIENVAT;
  int TIENLUUBO;
  int PBVMT4M3;
  int TIENPBVMT;
  int PNT4M3;
  int TIENPNT;
  int TONGCONG;
  int TTGHI;
  dynamic MAHTTT;
  dynamic MAHTTT_HT;
  dynamic HETNO;
  dynamic NGAYCN;
  dynamic NGAYNHAPCN;
  dynamic HDDT_MAUSO;
  dynamic HDDT_KYHIEU;
  dynamic GHICHU;
  dynamic KYHOADON;
  dynamic TRANGTHAITHANHTOAN;
  dynamic TRANGTHAI;
  dynamic TRANGTHAIHOADON;
  dynamic KHUVUC;
  dynamic SERIALSOHD;
  dynamic HasBill;
  dynamic ActionUrl;
  dynamic KYHD;
  dynamic MAPHATHANH;
  dynamic PHHOADON;
  dynamic TONGKYNO;
  dynamic TONGTIENNO;
  dynamic TTDIEUCHINH;
  dynamic NGAYPHHD;
  dynamic NGAYDIEUCHINH;
  dynamic NVDIEUCHINH;
  dynamic cashMANH;
  dynamic KEYPHHOADON;
  dynamic GNHOADON;
  dynamic NGAYGNHOADON;
  dynamic TTPHDIEUCHINH;
  dynamic NGAYPHDIEUCHINH;
  dynamic GIAMGIA;
  dynamic TINHPBVMT_PHANTRAM;
  dynamic TINHPBVMT_RUNG;
  dynamic PBVMT_RUNG;
  dynamic TIENPBVMT_RUNG;
  dynamic TINHNHANKHAU;
  dynamic NONGTHON;
  dynamic LOCKGCS;
  dynamic LOCKTINHCUOC;

  BillInfo({
    required this.IDKH,
    required this.NAM,
    required this.THANG,
    required this.STT,
    this.SOPHIEU,
    this.MAKV,
    this.MAQUAN,
    this.MAPHUONG,
    this.MADP,
    this.DUONGPHU,
    this.MALKHDB,
    this.MADB,
    this.SODB,
    this.HOTEN,
    this.DIACHI,
    this.DIACHI_KH,
    this.MST,
    this.SONK,
    required this.CSCU,
    required this.CSMOI,
    required this.M3TT,
    required this.M3TT1,
    required this.M3TT2,
    required this.M3TT3,
    this.MALKHDBTUNGKHOANG,
    this.DONGIATUNGKHOANG,
    this.M3TTTUNGKHOAN,
    this.THANHTIENTUNGKHOANG,
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
    this.MAHTTT,
    this.MAHTTT_HT,
    this.HETNO,
    this.NGAYCN,
    this.NGAYNHAPCN,
    this.HDDT_MAUSO,
    this.HDDT_KYHIEU,
    this.GHICHU,
    this.KYHOADON,
    this.TRANGTHAITHANHTOAN,
    this.TRANGTHAI,
    this.TRANGTHAIHOADON,
    this.KHUVUC,
    this.SERIALSOHD,
    this.HasBill,
    this.ActionUrl,
    this.KYHD,
    this.MAPHATHANH,
    this.PHHOADON,
    this.TONGKYNO,
    this.TONGTIENNO,
    this.TTDIEUCHINH,
    this.NGAYPHHD,
    this.NGAYDIEUCHINH,
    this.NVDIEUCHINH,
    this.cashMANH,
    this.KEYPHHOADON,
    this.GNHOADON,
    this.NGAYGNHOADON,
    this.TTPHDIEUCHINH,
    this.NGAYPHDIEUCHINH,
    this.GIAMGIA,
    this.TINHPBVMT_PHANTRAM,
    this.TINHPBVMT_RUNG,
    this.PBVMT_RUNG,
    this.TIENPBVMT_RUNG,
    this.TINHNHANKHAU,
    this.NONGTHON,
    this.LOCKGCS,
    this.LOCKTINHCUOC,
  });

  factory BillInfo.fromJson(Map<String, dynamic> responseData) {
    return BillInfo(
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
}
