import 'package:flutter/material.dart';
import 'package:medical_app/views/favourited_screen.dart';
import 'package:medical_app/views/landing_screen.dart';
import 'package:medical_app/views/news/news_screen.dart';
import 'package:medical_app/views/search_sreen.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/draw.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final List<String> appBarTitles = ['Home', 'Search', 'News', 'Favourite'];

  final List<IconData> appBarLeadingIcons = [
    Icons.menu,
    Icons.arrow_back,
    Icons.arrow_back,
    Icons.arrow_back,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(),
      drawer: const buildDrawer(),
      body: IndexedStack(
        index: currentIndex,
        children: [
          const LandingScreen(),
          const SearchScreen(),
          const NewsScreen(),
          FavouritedScreen(
            appBar: AppBar(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Screen 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Screen 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Screen 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Screen 4',
          ),
        ],
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryColor.withOpacity(0.2),
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      title: Text(appBarTitles[currentIndex]),
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
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
        icon: Icon(appBarLeadingIcons[currentIndex]),
      ),
    );
  }
}
