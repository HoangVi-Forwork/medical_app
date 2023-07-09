import 'package:flutter/material.dart';

import '../../../widgets/colors.dart';

//! Top Imge for Sign In Screen
Widget topImage(BuildContext context) {
  const String url = 'assets/images/22.jpg';
  return Container(
    width: 260,
    height: 300,
    margin: const EdgeInsets.only(top: 48),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
        bottomLeft: Radius.circular(200),
        bottomRight: Radius.circular(200),
      ),
      child: Image.asset(
        url,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/error_01.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text('Failed to load image'),
              ],
            ),
          );
        },
        fit: BoxFit.cover,
      ),
    ),
  );
}

//! Top Title for SignIn Screen

Widget topTile(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Medical Project',
          style: TextStyle(
            color: AppColors.primaryColor.withOpacity(1),
            fontSize: 26,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Đồng hành cùng chăm sóc sức khỏe của bạn!',
          style: TextStyle(
            color: AppColors.textColor.withOpacity(1),
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
