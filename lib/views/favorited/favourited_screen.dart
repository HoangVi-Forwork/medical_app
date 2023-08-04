// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FavouritedScreen extends StatefulWidget {
  const FavouritedScreen({Key? key}) : super(key: key);

  @override
  State<FavouritedScreen> createState() => _FavouritedScreenState();

  void addItemToFavorites(String value) {}
}

class _FavouritedScreenState extends State<FavouritedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Favourited"),
      ),
    );
  }
}
