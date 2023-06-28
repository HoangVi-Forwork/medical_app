// ignore_for_file: depend_on_referenced_packages, unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/model/list_deases_model.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/draw.dart';
import '../widgets/buttons/floating_scroll_button.dart';
import '../widgets/text_input_widgets/text_title_and_subtitle.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final imagePosterList = [
    'assets/images/POSTER_01.png',
    'assets/images/POSTER_02.png',
    'assets/images/POSTER_03.png',
  ];

  List<Map<String, dynamic>> iconsList = [
    {
      'icon': 'assets/icons/hospital.png',
      'label': 'Cấp cứu',
    },
    {
      'icon': 'assets/icons/stethoscope.png',
      'label': 'Khám bệnh',
    },
    {
      'icon': 'assets/icons/capsules.png',
      'label': 'Dược phẩm',
    },
    {
      'icon': 'assets/icons/injection.png',
      'label': 'Tiêm ngừa',
    },
    {
      'icon': 'assets/icons/blood-test.png',
      'label': 'Xét nghiệm',
    },
    {
      'icon': 'assets/icons/cardiogram.png',
      'label': 'Tim mạch',
    },
    {
      'icon': 'assets/icons/application.png',
      'label': 'Khác',
    },
  ];
  List<Map<String, dynamic>> newDiseaseList = [
    {
      "url":
          "https://login.medlatec.vn//ImagePath/images/20200824/20200824_Cam-lanh-1.jpg",
      "diseaseName": "Cảm lạnh",
      "indentificationSign": "Hắt hơi, sổ mũi, đau họng, ho, sốt nhẹ.",
      "diseaseObject": "Trẻ em và người già",
    },
    {
      "url":
          "https://tamanhhospital.vn/wp-content/uploads/2022/07/tac-nhan-gay-benh-sot-ret.jpg",
      "diseaseName": "Sốt rét",
      "indentificationSign":
          "Sốt, đau đầu, buồn nôn, co giật, mất ý thức, Sốt, nôn ói, tiêu chảy, đau bụng",
      "diseaseObject": "Trẻ em và người già",
    },
    {
      "url":
          "https://tamanhhospital.vn/wp-content/uploads/2021/09/nguyen-nhan-gay-viem-phoi.jpg",
      "diseaseName": "Viêm phổi",
      "indentificationSign": "Sốt, ho khan, khó thở, đau ngực",
      "diseaseObject": "Người già",
    },
    {
      "url":
          "https://hanoimoi.com.vn/Uploads/images/tuandiep/2019/08/13/Khong-tai-dan-o-nhung-co-so.jpg",
      "diseaseName": "Bệnh dịch tả",
      "indentificationSign":
          "Sốt, nôn ói, tiêu chảy, đau bụng, Sốt, nôn ói, tiêu chảy, đau bụng, Sốt, nôn ói, tiêu chảy, đau bụng, Sốt, nôn ói, tiêu chảy, đau bụng nôn ói, tiêu chảy, đau bụng, Sốt, nôn ói",
      "diseaseObject": "Trẻ em và người già",
    },
    {
      "url":
          "https://bcp.cdnchinhphu.vn/thumb_w/640/334894974524682240/2023/3/20/sxh-1679285610784870118864.jpg",
      "diseaseName": "Sốt xuất huyết",
      "indentificationSign":
          "Sốt, đau đầu, đau mắt, đau khớp, chảy máu nhiều, Sốt, nôn ói, tiêu chảy, đau bụng",
      "diseaseObject": "Trẻ em và người già",
    },
  ];

  // static showDiseases() async {
  //   List<ListDiseasesModel> diseases = [];
  //   const String endpoint = 'http://192.168.11.20:5090/danhsachbenh';
  //   try {
  //     final res = await http.get(Uri.parse(endpoint));
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //       data['diseases'].forEach((value) => {
  //             diseases.add(ListDiseasesModel(
  //               id_benh: value['id_benh'],
  //               tenbenh: value['tenbenh'],
  //               hinhanh: value['hinhanh'],
  //               trieuchung: value['trieuchung'],
  //               nguyennhan: value['nguyennhan'],
  //               phongngua: value['phongngua'],
  //               noidung: value['noidung'],
  //               id_loaibenh: value['id_loaibenh'],
  //               tenrieng: value['tenrieng'],
  //             ))
  //           });

  //       return diseases;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<List<ListDiseasesModel>> showDiseases() async {
    List<ListDiseasesModel> diseases = [];
    const String endpoint = 'http://10.7.134.227:5090/danhsachbenh';
    try {
      final res = await http.get(Uri.parse(endpoint));

      if (res.statusCode == 201) {
        var data = jsonDecode(res.body) as dynamic;

        print('have Data');
        data['diseases'].forEach((value, index) {
          diseases.add(ListDiseasesModel(
            id_benh: value[index]['id_benh'],
            tenbenh: value[index]['tenbenh'],
            hinhanh: value[index]['hinhanh'],
            trieuchung: value[index]['trieuchung'],
            nguyennhan: value[index]['nguyennhan'],
            phongngua: value[index]['phongngua'],
            noidung: value[index]['noidung'],
            id_loaibenh: value['id_loaibenh'],
            tenrieng: value['tenrieng'],
          ));
          // print('DATA: ' + data);
        });

        return diseases;
      } else {
        print("have Error");
        return [];
      }
    } catch (e) {
      print("have Error 2");
      print(e.toString());
      return [];
    }
  }

  // Future<List<ListDiseasesModel>> fetchDataFromServer() async {
  //   final res =
  //       await http.get(Uri.parse('http://10.7.134.227:5090/danhsachbenh'));
  //   if (res.statusCode == 201) {
  //     final data = jsonDecode(res.body);
  //     print('This is data: ' + data);
  //     return data as List<ListDiseasesModel>;
  //   } else {
  //     throw Exception('Failed to fetch data from server');
  //   }
  // }

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
              _topListViewPoster(imagePosterList),
              const textTitleAndSubTitle(
                textTitle: 'Dịch vụ',
                subTitle: 'Lựa chọn dịch vụ y tế',
              ),
              _serviceListIcons(iconsList),
              const textTitleAndSubTitle(
                textTitle: 'Bệnh phổ biến',
                subTitle: 'Hãy cẩn thận với sự thay đổi của thời tiết',
              ),
              // buildListOfCommonDiseases(),
              FutureBuilder(
                  future: showDiseases(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.pink,
                        ),
                      );
                    } else {
                      List<ListDiseasesModel> diseaseDatas = snapshot.data!;
                      print(diseaseDatas);
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: BuildFloatingActionScrollButton(
        isVisibale: isVisibale,
        scrollController: scrollController,
      ),
      //bottomNavigationBar: const buildBottomNavigationBar(),
    );
  }

  // List Of Common Diseases
  // Container _buildListOfCommonDiseases() {
  //   return Container(
  //     width: double.infinity,
  //     margin: const EdgeInsets.symmetric(vertical: 24),
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: newDiseaseList.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: double.infinity,
  //           height: 160,
  //           margin: const EdgeInsets.only(
  //             bottom: 16,
  //             left: 4,
  //             right: 4,
  //           ),
  //           padding: const EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             color: const Color.fromARGB(255, 255, 255, 255),
  //             borderRadius: BorderRadius.circular(12),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.3),
  //                 blurRadius: 12.0,
  //                 spreadRadius: 0.0,
  //                 offset: const Offset(0.0, 0.1),
  //               )
  //             ],
  //           ),
  //           child: Center(
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   width: 86,
  //                   height: double.infinity,
  //                   margin: const EdgeInsets.only(bottom: 12),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(6),
  //                     child: Image.network(
  //                       newDiseaseList[index]['url'],
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 19,
  //                 ),
  //                 Expanded(
  //                   child: SizedBox(
  //                     width: double.infinity,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           newDiseaseList[index]['diseaseName'],
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                             fontFamily: GoogleFonts.tajawal().toString(),
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 8,
  //                         ),
  //                         Text(
  //                           newDiseaseList[index]['indentificationSign'],
  //                           softWrap: true,
  //                           overflow: TextOverflow.visible,
  //                           maxLines: 2,
  //                           style: const TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.normal,
  //                           ),
  //                         ),
  //                         Container(
  //                           margin: const EdgeInsets.only(top: 4, bottom: 4),
  //                           child: const Divider(
  //                             height: 1,
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 6,
  //                         ),
  //                         Text(
  //                           'Đối tượng: ${newDiseaseList[index]['diseaseObject']}',
  //                           softWrap: true,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: const TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         Container(
  //                           width: double.infinity,
  //                           margin: const EdgeInsets.only(top: 2),
  //                           alignment: Alignment.bottomRight,
  //                           child: TextButton.icon(
  //                             onPressed: () {},
  //                             label: const Text('Đọc thêm',
  //                                 style: TextStyle(
  //                                   color: AppColors.primaryColor,
  //                                 )),
  //                             icon: const Icon(
  //                               Icons.arrow_right_alt,
  //                               color: AppColors.primaryColor,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Container buildListOfCommonDiseases() {
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
          }),
    );
  }

  // Top List Poster
  Container _topListViewPoster(List<String> imagePosterList) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePosterList.length,
        itemBuilder: (context, index) {
          return Container(
            width: 354,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 217, 217, 217).withOpacity(1),
                  blurRadius: 6.0,
                  spreadRadius: 0.1,
                  offset: const Offset(3, 3),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePosterList[index],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
