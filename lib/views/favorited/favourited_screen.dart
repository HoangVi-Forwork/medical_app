// import 'package:flutter/material.dart';
// import 'package:medical_app/model/news_model.dart';

// class FavouritedScreen extends StatelessWidget {
//   final List<NewsModel> favouritedNewsList;

//   const FavouritedScreen({Key? key, required this.favouritedNewsList})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Favourite News'),
//       // ),
//       body: ListView.builder(
//         itemCount: favouritedNewsList.length,
//         itemBuilder: (context, index) {
//           final NewsModel news = favouritedNewsList[index];
//           return ListTile(
//             title: Text(news.tieuDe.toString()),
//             subtitle: Text(news.gioiThieu.toString()),
//           );
//         },
//       ),
//     );
//   }
// }
// File: favourited_screen.dart
import 'package:flutter/material.dart';

class FavouritedScreen extends StatefulWidget {
  const FavouritedScreen({Key? key}) : super(key: key);

  @override
  State<FavouritedScreen> createState() => _FavouritedScreenState();

  void addItemToFavorites(String value) {}
}

class _FavouritedScreenState extends State<FavouritedScreen> {
  List<String> favouriteItems = [];

  void addItemToFavorites(String item) {
    setState(() {
      favouriteItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Favourite News'),
      // ),
      body: ListView.builder(
        itemCount: favouriteItems.length,
        itemBuilder: (context, index) {
          final item = favouriteItems[index];
          return ListTile(
            title: Container(
              width: 220,
              height: 150,
              color: Colors.green,
              child: Text(item),
            ),
          );
        },
      ),
    );
  }
}
