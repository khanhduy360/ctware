// METHOD API

class Url {
  // Server config
  static const domain = 'apidemo.ctn-cantho.com.vn';
  static const urlSite = "https://$domain/api/ctwapi/";
  static const version = 'v1';
  static const platformId = 3;
  static const platformType = 3;
  // Users
  static const login = "$version/Users/Login"; // POST
  static const getUser = "$version/Users/GetUser"; // GET
  static const contracts = "$version/Users/Contracts?pId=$platformId"; //GET
  static const bills = "$version/Users/GetBills?pId=$platformId"; //GET
  static const updateUser = "$version/Users/UpdateUser"; //PATCH
  static const changePassword = "$version/Users/ChangePass"; //POST
  static const sendPipeReport = "$version/Users/SendPipeReport"; // POST
  static const getListPipeReport = "$version/Users/GetListPipeReport"; // GET
  static const userRequests = "$version/Users/UserRequests"; // GET
  static const sendRequests = "$version/Users/SendRequests"; // POST
  static const getResponses = "$version/Users/GetResponses"; // GET
  static const sendResponse = "$version/Users/SendResponse"; // POST
  static const deleteBill = "$version/Users/DeleteBill"; // POST
  static const getHoaDon = "$version/Users/GetHoaDon"; // POST
  static const addBill = "$version/Users/AddBill"; // POST
  static const checkKhachHangGCS = "$version/Users/CheckKhachHangGCS"; // POST
  static const thongTinHoaDon = "$version/Users/ThongTinHoaDon"; // POST
  static const ghiChiSoOnl = "$version/Users/GhiChiSoOnl"; // POST
  // Common
  static const chuyenMucTin = "$version/Common/ChuyenMucTin"; //GET
  static const advertiseSlide = "$version/Common/AdvertiseSlide"; //GET
  static const traCuuDiaDiem = "$version/Common/TraCuuDiaDiem"; //GET
  static const config = "$version/Common/Config"; //GET
  static const requestTypes = "$version/Common/RequestTypes"; //GET
  // Statistic
  static const traCuu = "$version/Statistic/TraCuu"; //POST
}