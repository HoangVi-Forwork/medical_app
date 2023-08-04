// ignore_for_file: depend_on_referenced_packages, unused_import
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medical_app/blocs/diseases/bloc/disease_bloc.dart';
import 'package:medical_app/model/diseases_model.dart';
import 'package:medical_app/repositories/diseases_repositories.dart';
import 'package:medical_app/utils/container_utils.dart';
import 'package:medical_app/views/home/home_detail_disease.dart';
import 'package:medical_app/views/home/home_utils.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/draw.dart';
import '../../model/news_model.dart';
import '../../widgets/buttons/floating_scroll_button.dart';
import '../../widgets/home/build_list_of_common_diseases.dart';
import '../../widgets/home/text_title_and_subtitle.dart';
import 'package:http/http.dart' as http;
import '../diseases/disease_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DiseaseRepository diseaseRepository = DiseaseRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> iconsList = HomeUtils.iconsList;
  final Container topViewPosterList = HomeUtils.TopListViewPoster(
    imagePosterList: [
      'assets/images/POSTER_01.png',
      'assets/images/POSTER_02.png',
      'assets/images/POSTER_03.png',
    ],
  );
  final ScrollController scrollController = ScrollController();
  // listen for user actions funcs
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const buildDrawer(),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              topViewPosterList,
              const textTitleAndSubTitle(
                textTitle: 'Dịch vụ',
                subTitle: 'Lựa chọn dịch vụ y tế',
              ),
              _serviceListIcons(iconsList),
              const textTitleAndSubTitle(
                textTitle: 'Bệnh phổ biến',
                subTitle: 'Hãy cẩn thận với sự thay đổi của thời tiết',
              ),
              diseaseListBody(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DiseaseListScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Xem Thêm',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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

  Container diseaseListBody() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 560),
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      child: BlocProvider(
        create: (context) => DiseaseBloc(
          DiseaseRepository(),
        )..add(
            FetchDiseasesEvent(),
          ),
        child: BlocBuilder<DiseaseBloc, DiseaseState>(
          builder: (context, state) {
            if (state is DiseaseLoadingState) {
              return ContainerUtils.loadingStateContainer0;
            } else if (state is DiseaseErrorState) {
              return Container(
                margin: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset('assets/icons/loading_book.gif'),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        state.errorMessage.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is DiseaseLoadedState) {
              List<DiseasesModel> listDisease = state.diseasesList;
              var litmitedLen = 4;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: listDisease.length,
                  itemCount: litmitedLen,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 96,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(8),
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
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeDetailDisease(
                                diseases: listDisease[index],
                              ),
                            ),
                          );
                        },
                        leading: SizedBox(
                          width: 56,
                          height: 56,
                          child: Image.network(
                            '${listDisease[index].hinhAnh}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            listDisease[index].tenBenh.toString().toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Text(
                          listDisease[index].trieuChung.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Service List Icons
  Container _serviceListIcons(iconsList) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(left: 20, right: 0, top: 12),
      padding: const EdgeInsets.all(6),
      // color: Colors.pink,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: iconsList.length,
        itemBuilder: (context, index) {
          String iconPath = iconsList[index]['icon'];
          String label = iconsList[index]['label'];
          return GestureDetector(
            onTap: () {
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.white,
                    content: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Dịch vụ chưa khả dụng'),
                    ),
                  ),
                );
              });
            },
            child: Column(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 217, 217, 217)
                            .withOpacity(1),
                        blurRadius: 6.0,
                        spreadRadius: 0.1,
                        offset: const Offset(3, 3),
                      )
                    ],
                  ),
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(label),
              ],
            ),
          );
        },
      ),
    );
  }
}
