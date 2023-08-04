import 'package:flutter/material.dart';

import '../../../widgets/colors.dart';

Widget topImage(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 300,
    color: Colors.grey,
    child: Image.network(
      'https://i.pinimg.com/564x/e0/c8/0e/e0c80e4c6fad4391f14d371f9d86683f.jpg',
      fit: BoxFit.cover,
    ),
  );
}

Widget topTitle(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        'Sign Up',
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
        'Register to become a member of our healthcare community and experience top-notch healthcare services. ',
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
