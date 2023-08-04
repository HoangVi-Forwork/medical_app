// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medical_app/widgets/colors.dart';

import '../../model/diseases_model.dart';

class HomeDetailDisease extends StatelessWidget {
  final DiseasesModel diseases;

  const HomeDetailDisease({
    super.key,
    required this.diseases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primaryColor,
        title: Text(diseases.tenBenh!),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: () {
              print('Thêm vào mục quan tâm');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  diseases.hinhAnh!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                diseases.tenRieng!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainContext(
                        'Triệu chứng:',
                        diseases.nguyenNhan.toString(),
                      ),
                      _buildMainContext(
                        'Nguyên nhân:',
                        diseases.nguyenNhan.toString(),
                      ),
                      _buildMainContext(
                        'Phòng ngừa:',
                        diseases.phongNgua.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Html(
                data: diseases.noiDung!,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildMainContext(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Html(
            data: content,
          ),
        ],
      ),
    );
  }
}
