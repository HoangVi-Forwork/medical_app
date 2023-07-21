import 'package:flutter/material.dart';
import 'package:medical_app/model/news_model.dart';

class FavouritedScreen extends StatelessWidget {
  final List<NewsModel> favouritedNewsList;

  const FavouritedScreen({Key? key, required this.favouritedNewsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite News'),
      ),
      body: ListView.builder(
        itemCount: favouritedNewsList.length,
        itemBuilder: (context, index) {
          final NewsModel news = favouritedNewsList[index];
          return ListTile(
            title: Text(news.tieuDe.toString()),
            subtitle: Text(news.gioiThieu.toString()),
          );
        },
      ),
    );
  }
}
