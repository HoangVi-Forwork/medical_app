import 'package:flutter/material.dart';

import '../widgets/colors.dart';

class ContainerUtils {
  static Center loadingStateContainer0 = Center(
    child: Column(
      children: [
        Image.asset('assets/icons/loading_book.gif'),
        const SizedBox(
          height: 24,
        ),
        const Text(
          'Đang tải dữ liệu\nVui lòng chờ!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textColor,
          ),
        ),
      ],
    ),
  );

  static Center emptyDataLoadingState = Center(
    child: Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 86,
            height: 86,
            child: Image.asset(
              'assets/icons/band-aid.gif',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Không có dữ liệu\nHãy thử nhập lại!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    ),
  );

  // USING IN NEWS SCREEN
  static Container loadingStateContainer = Container(
    margin: const EdgeInsets.all(24),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/loading_book.gif'),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Đang tải dữ liệu\nVui lòng chờ!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    ),
  );

  // USING IN NEWS SCREEN
  static Container loadingErrorStateContainer = Container(
    margin: const EdgeInsets.all(24),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/icons8-breaking-news.gif',
            width: 56,
            height: 56,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Có một tí lỗi, Quay lại sau nhé!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    ),
  );
}
