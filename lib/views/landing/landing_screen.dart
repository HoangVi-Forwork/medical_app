import 'package:flutter/material.dart';
import 'package:medical_app/views/home/home_screen.dart';
import 'package:medical_app/views/landing/landing_utils.dart';
import 'package:medical_app/views/news/news_screen.dart';
import 'package:medical_app/views/search/search_sreen.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/draw.dart';

import '../favorited/favourited_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final List<IconData> appBarLeadingIcons = LandingUtils.appBarLeadingIcons;
  final List<IconData> appBarActionIcons = LandingUtils.appBarActionIcons;
  final List<String> appBarTitles = LandingUtils.appBarTitles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(),
      drawer: const buildDrawer(),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          SearchScreen(),
          NewsScreen(),
          FavouritedScreen(
              // favouritedNewsList: [],
              ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigator(),
    );
  }

  BottomNavigationBar buildBottomNavigator() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            currentIndex = index;
          });
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'landing Screen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search Screen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'News Screen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Favorited Screen',
        ),
      ],
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.primaryColor.withOpacity(0.2),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      title: Text(
        appBarTitles[currentIndex],
        style: const TextStyle(
          color: AppColors.primaryColor,
        ),
      ),
      elevation: 0,
      // backgroundColor: AppColors.primaryColor,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          if (currentIndex == 0) {
            _scaffoldKey.currentState?.openDrawer();
          } else {
            setState(() {
              currentIndex = 0;
            });
          }
        },
        icon: Icon(
          appBarLeadingIcons[currentIndex],
          color: AppColors.primaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            appBarActionIcons[currentIndex],
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }
}
