import 'package:cached_network_image/cached_network_image.dart';
import 'package:ctware/model/news.dart';
import 'package:ctware/model/news_item.dart';
import 'package:ctware/screens/news/news_web_view.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsListItemsView extends StatelessWidget {
  const NewsListItemsView({super.key, required this.newsData});
  final News newsData;

  Widget _newsItemTopicView(BuildContext context, NewsItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsWebView(
                      title: item.title ?? '',
                      url: item.link ?? '',
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        decoration: BoxStyle.fromBoxDecoration(radius: 20),
        child: SizedBox(
          height: 410,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())),
                  imageUrl: item.imgUrl ?? '',
                  height: 230,
                  width: Responsive.width(100, context),
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(item.description ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                          item.pubDate != null
                              ? DateFormat('dd/MM/yyyy H:mm:ss')
                                  .format(item.pubDate!)
                              : '',
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Tin tức',
      body: SingleChildScrollView(
          child: Column(
              children: newsData.items
                  .map((item) => _newsItemTopicView(context, item))
                  .toList())),
    );
  }
}
