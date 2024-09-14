// ignore_for_file: non_constant_identifier_names
// map to API

import 'package:ctware/configs/utilities.dart';
import 'package:rss_dart/dart_rss.dart';

class NewsItem {
  String? title;
  String? link;
  DateTime? pubDate;
  String? description;
  String? imgUrl;

  NewsItem();

  factory NewsItem.fromRss(RssItem rssItem) {
    final newsItem = NewsItem();
    newsItem.title = rssItem.title;
    newsItem.link = rssItem.link;
    newsItem.pubDate = parseRssDate(rssItem.pubDate ?? '');
    final descriptionRes = rssItem.description ?? '';
    RegExp imageUrlExp = RegExp(r'<img src="(.*?)"');
    newsItem.imgUrl = imageUrlExp.firstMatch(descriptionRes)?.group(1) ?? '';
    RegExp imgTagExp = RegExp(r'<img.*?>');
    newsItem.description = descriptionRes.replaceAll(imgTagExp, '').trim();
    return newsItem;
  }
}
