import 'package:ctware/api/api_config.dart';
import 'package:ctware/api/url.dart';
import 'package:ctware/model/advertise_slide.dart';
import 'package:ctware/model/bank_location.dart';
import 'package:ctware/model/news.dart';
import 'package:ctware/model/news_item.dart';
import 'package:rss_dart/dart_rss.dart';

class CommonService extends ApiService {
  CommonService({required super.context});

  Future<List<News>> getNewsApi() async {
    final response = await fetch(Url.chuyenMucTin);
    final newsList = <News>[];
    if (response != null && response.statusCode == 200) {
      for(var value in response.data) {
        var news = News.fromJson(value);
        if(value['Url'] != null && value['Url'] != '') {
          final responseItem = await fetch(value['Url']);
          if (responseItem != null && responseItem.statusCode == 200) {
            final rssFeed = RssFeed.parse(responseItem.data);
            for(var item in rssFeed.items) {
              news.items.add(NewsItem.fromRss(item));
            }
          }
        }
        newsList.add(news);
      }
    }
    newsList.sort((a, b) => a.ThuTu.compareTo(b.ThuTu));
    return newsList;
  }

  Future<List<AdvertiseSlide>> getAdvertiseSlideApi() async {
    final response = await fetch(Url.advertiseSlide);
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