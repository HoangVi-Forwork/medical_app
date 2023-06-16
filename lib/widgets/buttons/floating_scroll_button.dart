import 'package:flutter/material.dart';
import '../colors.dart';

class BuildFloatingActionScrollButton extends StatelessWidget {
  const BuildFloatingActionScrollButton({
    Key? key,
    required this.isVisibale,
    required this.scrollController,
  }) : super(key: key);

  final bool isVisibale;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisibale,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: 0.75,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 12.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 0.1),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              Icons.arrow_upward,
            ),
          ),
        ),
      ),
    );
  }
}
