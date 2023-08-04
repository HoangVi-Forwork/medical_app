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
