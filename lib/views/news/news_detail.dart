import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../widgets/container_config/container_customization.dart';

class NewsDatailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final String? postTime;
  const NewsDatailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.postTime,
  });

  @override
  Widget build(BuildContext context) {
    //final List<String> textParagraphs = content.trim().split('.');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tin Mới"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      // endDrawer: const buildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: GoogleFonts.poppins().toString(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    postTime.toString(),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  ContainersCustomization.dividerInContainer(),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ContainersCustomization.dividerInContainer(),
              Html(
                data: content,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const buildBottomNavigationBar(),
    );
  }
}