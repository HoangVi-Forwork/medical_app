import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';

import '../model/diseases_model.dart';

class HomeDetailDisease extends StatelessWidget {
  final DiseasesModel diseases;
  const HomeDetailDisease({super.key, required this.diseases});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highLightColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primaryColor,
        title: Text(diseases.tenBenh!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tên khác: ${diseases.tenRieng!}'),
              const SizedBox(
                height: 16,
              ),
              Image.network(
                diseases.hinhAnh!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              Text('Nguyên Nhân: \n${diseases.nguyenNhan}'),
              const SizedBox(
                height: 16,
              ),
              Text('Triệu chứng: \n${diseases.noiDung}'),
            ],
          ),
        ),
      ),
    );
  }
}
