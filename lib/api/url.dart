// METHOD API

class Url {
  static const version = 'v1';
  static const platformId = 3;
  // Users
  static const login = "$version/Users/Login"; // POST
  static const getUser = "$version/Users/GetUser"; // GET
  static const contracts = "$version/Users/Contracts?pId=$platformId"; //GET
  // Common
  static const chuyenMucTin = "$version/Common/ChuyenMucTin"; //GET
  static const advertiseSlide = "$version/Common/AdvertiseSlide"; //GET
  static const traCuuDiaDiem = "$version/Common/TraCuuDiaDiem"; //GET
}