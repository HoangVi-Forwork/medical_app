// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomeUtils {
  static List<Map<String, dynamic>> iconsList = [
    {
      'icon': 'assets/icons/hospital.png',
      'label': 'Cấp cứu',
    },
    {
      'icon': 'assets/icons/stethoscope.png',
      'label': 'Khám bệnh',
    },
    {
      'icon': 'assets/icons/capsules.png',
      'label': 'Dược phẩm',
    },
    {
      'icon': 'assets/icons/injection.png',
      'label': 'Tiêm ngừa',
    },
    {
      'icon': 'assets/icons/blood-test.png',
      'label': 'Xét nghiệm',
    },
    {
      'icon': 'assets/icons/cardiogram.png',
      'label': 'Tim mạch',
    },
    {
      'icon': 'assets/icons/application.png',
      'label': 'Khác',
    },
  ];

  // Top List Poster
  static Container TopListViewPoster({required List<String> imagePosterList}) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePosterList.length,
        itemBuilder: (context, index) {
          return Container(
            width: 354,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 217, 217, 217).withOpacity(1),
                  blurRadius: 6.0,
                  spreadRadius: 0.1,
                  offset: const Offset(3, 3),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePosterList[index],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
