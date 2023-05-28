import 'package:flutter/material.dart';

class ContainersCustomization {
  static Widget dividerInContainer({
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 16),
      child: const Divider(height: 1, color: Colors.grey),
    );
  }
}
