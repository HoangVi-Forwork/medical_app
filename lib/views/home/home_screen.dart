// ignore_for_file: depend_on_referenced_packages, unused_import, no_leading_underscores_for_local_identifiers
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../medical/medical_register.dart';

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
  final List<Map<String, String>> emergencyNumbers = [
    {'label': 'Gọi Cấp Cứu', 'number': '115'},
    {'label': 'Cứu Hỏa', 'number': '114'},
    {'label': 'Công an hoặc cảnh sát', 'number': '113'},
    {'label': 'Cứu nạn, cứu hộ khẩn cấp', 'number': '112'},
    {'label': 'Tổng đài điện thoại quốc gia bảo vệ trẻ em', 'number': '111'},
    {'label': 'Người thân', 'number': '0907656495'},
  ];

  final Uri urlPharmacityWeb = Uri.parse(
      'https://www.pharmacity.vn/?gclid=CjwKCAjw8symBhAqEiwAaTA__AsBqZ4eqkMply1zx1GDqY6dbZZSJStJ6gQczjsnEROZNnM72JaKfhoCd1wQAvD_BwE');
  final Uri urlVNVC = Uri.parse('https://vnvc.vn/dang-ky-tiem-chung/');
  final Uri urlDiag = Uri.parse('https://diag.vn/');
  void _onOpenPharmacityWeb() async {
    if (await launchUrl(urlPharmacityWeb)) {
      await launchUrl(urlPharmacityWeb);
    }
  }

  void _onOpenVNVCWeb() async {
    if (await launchUrl(urlVNVC)) {
      await launchUrl(urlVNVC);
    }
  }

  void _onOpenDiagWeb() async {
    if (await launchUrl(urlDiag)) {
      await launchUrl(urlDiag);
    }
  }

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const BuildDrawer(),
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
          void _onOpenEmerPhone() async {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  elevation: 10,
                  backgroundColor: Colors.white,
                  title: Column(
                    children: const [
                      Text(
                        'CUỘC GỌI KHẨN CẤP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Chỉ sử dụng khi thật sự cần thiết!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        height: 1.5,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  children: [
                    Column(
                      children: emergencyNumbers
                          .map((emergency) => Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '${emergency['label']!}: ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '📞: ${emergency['number']!}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      launch("tel://${emergency['number']}");
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: const Divider(
                                        height: 1.5,
                                        color: Colors.grey,
                                        indent: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                    Container(
                      width: double.infinity,
                      height: 44,
                      margin: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 30),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(0);
                        },
                        child: const Center(
                          child: Text(
                            'Hủy bỏ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }

          return GestureDetector(
            onTap: () {
              if (index == 0) {
                _onOpenEmerPhone();
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              } else if (index == 2) {
                _onOpenPharmacityWeb();
              } else if (index == 3) {
                _onOpenVNVCWeb();
              } else if (index == 4) {
                _onOpenDiagWeb();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.white,
                    duration: const Duration(seconds: 2),
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
              }
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
