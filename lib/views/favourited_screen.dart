import 'package:flutter/material.dart';

class FavouritedScreen extends StatelessWidget {
  //final AppBar appBar;
  const FavouritedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // appBar: appBar,
      body: const Center(
        child: Text("Favourited Screen"),
      ),
    );
  }
}
