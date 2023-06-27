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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              margin: const EdgeInsets.only(bottom: 24),
              child: Image.asset(
                'assets/icons/health-check.png',
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Danh sách bạn quan tâm sẽ hiển thị ở đây",
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
