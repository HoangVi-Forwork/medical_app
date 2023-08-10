import 'dart:io';

import 'package:flutter/material.dart';

class QrCodeScreen extends StatelessWidget {
  final String imagePath;

  const QrCodeScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mã QR đã lưu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(imagePath)),
            SizedBox(height: 16),
            Text('Hình ảnh mã QR đã lưu'),
          ],
        ),
      ),
    );
  }
}
