import 'package:ctware/model/news.dart';
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
}