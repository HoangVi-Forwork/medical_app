import 'package:flutter/material.dart';
import 'package:medical_app/views/favourited_screen.dart';
import 'package:medical_app/views/home_screen.dart';
import 'package:medical_app/views/landing_screen.dart';
import 'package:medical_app/views/news/news_screen.dart';
import '../colors.dart';

// ignore: camel_case_types
class buildBottomNavigationBar extends StatefulWidget {
  const buildBottomNavigationBar({
    super.key,
  });

  @override
  State<buildBottomNavigationBar> createState() =>
      _buildBottomNavigationBarState();
}

class _buildBottomNavigationBarState extends State<buildBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 3,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper,
          ),
          label: 'Mail',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark,
          ),
          label: 'Mail',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Person',
        ),
      ],
      backgroundColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.primaryColor.withOpacity(0.2),
    );
  }
}
