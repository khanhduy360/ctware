import 'package:cached_network_image/cached_network_image.dart';
import 'package:ctware/model/news.dart';
import 'package:ctware/provider/news_provider.dart';
import 'package:ctware/screens/news/news_list_items_view.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key});

  Widget _newsItemView(BuildContext context, News item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsListItemsView(newsData: item)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(marginLayoutBase),
        decoration: BoxStyle.fromBoxDecoration(radius: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator())),
              imageUrl: item.Image ?? '',
              height: 90,
              width: 120,
              fit: BoxFit.fill,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.Title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(item.Description ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Tin tức',
        backAction: false,
        body: SingleChildScrollView(
          child: Consumer<NewsProvider>(
            builder: (context, dataProvider, child) {
              if (dataProvider.news.isEmpty) {
                return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(marginLayoutBase),
                    child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()));
              }
              return Column(
                  children: dataProvider.news
                      .map((item) => _newsItemView(context, item))
                      .toList());
            },
          ),
        ));
  }
}
