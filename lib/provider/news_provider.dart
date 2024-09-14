import 'package:ctware/model/news.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<News> news = [];
  void setUser(List<News> newsParam) {
    news = newsParam;
    notifyListeners();
  }
}