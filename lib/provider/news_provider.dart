import 'package:ctware/model/news.dart';
import 'package:ctware/model/news_item.dart';
import 'package:ctware/services/common_service.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<News> news = [];

  Future<List<News>> futureNews(BuildContext context) async {
    final commonService = CommonService(context: context);
    final futureNews = await commonService.getNewsApi();
    news = futureNews;
    notifyListeners();
    return futureNews;
  }

  List<NewsItem> getNewsItemHot() {
    final rs = <NewsItem>[];
    for(var items in news) {
      rs.addAll(items.items);
    }
    rs.sort((a, b) {
      if(a.pubDate == null && b.pubDate == null) {
        return 0;
      }
      if(a.pubDate == null) {
        return -1;
      } else if(b.pubDate == null) {
        return 1;
      }
      return b.pubDate!.compareTo(a.pubDate ?? DateTime.now());
    });

    return rs.sublist(0, 5);
  }
}