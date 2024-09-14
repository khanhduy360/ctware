// ignore_for_file: non_constant_identifier_names
// map to API
import 'package:ctware/model/news_item.dart';

class News {
  int Id;
  int CatId;
  String? Title;
  String? Description;
  String? Url;
  String? Image;
  int ThuTu;

  List<NewsItem> items = <NewsItem>[];

  News({
    required this.Id,
    required this.CatId,
    required this.Title,
    required this.Description,
    required this.Url,
    required this.Image,
    required this.ThuTu,
  });

  factory News.fromJson(Map<String, dynamic> responseData) {
    return News(
      Id: responseData['Id'],
      CatId: responseData['CatId'],
      Title: responseData['Title'],
      Description: responseData['Description'],
      Url: responseData['Url'],
      Image: responseData['Image'],
      ThuTu: responseData['ThuTu'],
    );
  }
}