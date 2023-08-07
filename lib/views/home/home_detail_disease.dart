// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medical_app/widgets/colors.dart';

import '../../blocs/favourites/bloc/favourites_bloc.dart';
import '../../model/diseases_model.dart';
import '../../widgets/buttons/floating_scroll_button.dart';

class HomeDetailDisease extends StatefulWidget {
  final DiseasesModel diseases;

  const HomeDetailDisease({
    super.key,
    required this.diseases,
  });

  @override
  State<HomeDetailDisease> createState() => _HomeDetailDiseaseState();
}

class _HomeDetailDiseaseState extends State<HomeDetailDisease> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.diseases.tenBenh!),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: (() {
              final favBloc = context.read<FavouritesBloc>();
              final disItem = favBloc.state.diseasesItems;

              if (disItem
                  .any((item) => item.idBenh == widget.diseases.idBenh)) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.orange,
                  content: Text(
                    'Bệnh lý đã được quan tâm!',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                ));
              } else {
                favBloc.add(AddToFav(widget.diseases));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: AppColors.primaryColor,
                  content: Text(
                    'Đã thêm vào mục quan tâm!',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                ));
              }
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.diseases.hinhAnh!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.diseases.tenRieng!,
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
                        widget.diseases.nguyenNhan.toString(),
                      ),
                      _buildMainContext(
                        'Nguyên nhân:',
                        widget.diseases.nguyenNhan.toString(),
                      ),
                      _buildMainContext(
                        'Phòng ngừa:',
                        widget.diseases.phongNgua.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Html(
                data: widget.diseases.noiDung!,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: BuildFloatingActionScrollButton(
        isVisibale: isVisibale,
        scrollController: scrollController,
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
