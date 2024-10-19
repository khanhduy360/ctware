// METHOD API

class Url {
  static const version = 'v1';
  static const platformId = 3;
  // Users
  static const login = "$version/Users/Login"; // POST
  static const getUser = "$version/Users/GetUser"; // GET
  static const contracts = "$version/Users/Contracts?pId=$platformId"; //GET
  static const bills = "$version/Users/GetBills?pId=$platformId"; //GET
  static const updateUser = "$version/Users/UpdateUser"; //PATCH
  static const changePassword = "$version/Users/ChangePass"; //POST
  // Common
  static const chuyenMucTin = "$version/Common/ChuyenMucTin"; //GET
  static const advertiseSlide = "$version/Common/AdvertiseSlide"; //GET
  static const traCuuDiaDiem = "$version/Common/TraCuuDiaDiem"; //GET
  static const config = "$version/Common/Config"; //GET
  // Statistic
  static const traCuu = "$version/Statistic/TraCuu"; //POST
}