import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/advertise_slide.dart';
import 'package:ctware/model/bank_location.dart';
import 'package:ctware/model/news.dart';

class CommonService extends ApiService {
  CommonService({required super.context});

  Future<News?> getNewsApi() async {
    final response = await fetchByToken(Url.chuyenMucTin);
    if (response != null && response.statusCode == 200) {
      return News.fromJson(response.data);
    }

    return null;
  }

  Future<List<AdvertiseSlide>> getAdvertiseSlideApi() async {
    final response = await fetchByToken(Url.advertiseSlide);
    final listAdvertiseSlide = <AdvertiseSlide>[];
    if (response != null && response.statusCode == 200) {
      for(var value in response.data) {
        listAdvertiseSlide.add(AdvertiseSlide.fromJson(value));
      }
    }

    return listAdvertiseSlide;
  }

  Future<List<BankLocation>> getBankLocation() async {
    final response = await fetch(Url.traCuuDiaDiem);
    final listBankLocation = <BankLocation>[];
    if (response != null && response.statusCode == 200) {
      for(var value in response.data) {
        listBankLocation.add(BankLocation.fromJson(value));
      }
    }

    return listBankLocation;
  }
}