import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Use SvgPicture as a background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/searchBackground.svg',
              color: Colors.transparent,
              fit: BoxFit.cover,
            ),
          ),
          // Use Center to position your text
          const Center(
            child: Text("Tìm kiếm"),
          ),
        ],
      ),
    );
  }
}
