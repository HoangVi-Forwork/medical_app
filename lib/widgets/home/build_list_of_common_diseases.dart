import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

Container buildListOfCommonDiseases(newDiseaseList) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 24),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newDiseaseList.length,
      itemBuilder: (context, index) {
        final disease = newDiseaseList[index];
        return Container(
          width: double.infinity,
          height: 160,
          margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 12.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 0.1),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 86,
                height: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    disease['url'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 19),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease['diseaseName'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.tajawal().toString(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      disease['indentificationSign'],
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      child: const Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Đối tượng: ${disease['diseaseObject']}',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 2),
                      alignment: Alignment.bottomRight,
                      child: TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          'Đọc thêm',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        icon: const Icon(
                          Icons.arrow_right_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
