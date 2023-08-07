// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../widgets/buttons/floating_scroll_button.dart';
import '../../widgets/container_config/container_customization.dart';

class NewsDatailScreen extends StatefulWidget {
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
  State<NewsDatailScreen> createState() => _NewsDatailScreenState();
}

class _NewsDatailScreenState extends State<NewsDatailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  bool isVisibale = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(
          () {
            isVisibale = false;
          },
        );
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isVisibale = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final List<String> textParagraphs = content.trim().split('.');
    return Scaffold(
      key: _scaffoldKey,
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
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
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
                    widget.postTime.toString(),
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
                    widget.imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ContainersCustomization.dividerInContainer(),
              Html(
                data: widget.content,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const buildBottomNavigationBar(),
      floatingActionButton: BuildFloatingActionScrollButton(
        isVisibale: isVisibale,
        scrollController: scrollController,
      ),
    );
  }
}
