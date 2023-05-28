import 'package:flutter/material.dart';

import '../widgets/colors.dart';

//! Top Imge for Sign In Screen
Widget topImage(BuildContext context) {
  const String url =
      'https://i.pinimg.com/564x/d0/54/14/d0541464bb5055e62b2d98435184ceb6.jpg';
  return Container(
    width: double.infinity,
    height: 300,
    color: AppColors.whiteColor,
    child: Image.network(
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
  );
}

//! Top Title for SignIn Screen

Widget topTile(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        'Login Account',
        style: TextStyle(
          color: AppColors.textColor.withOpacity(1),
          fontSize: 26,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        'Please log in to continue using our professional and convenient healthcare services.',
        style: TextStyle(
          color: AppColors.textColor.withOpacity(0.6),
          fontSize: 16,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.normal,
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: const Divider(
          height: 1,
          color: Colors.black,
        ),
      )
    ],
  );
}
