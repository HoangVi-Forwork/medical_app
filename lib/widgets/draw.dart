// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/container_config/container_customization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/auth/auth_bloc.dart';
import '../config/url_config.dart';
import 'package:http/http.dart' as http;

import '../views/auth/sign_in/sign_in_screen.dart';

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final String userImageUrl =
      'https://i.pinimg.com/564x/ec/fd/c0/ecfdc07b30149c927956fe5bb6126e2c.jpg';

  String userEmail = "";

  @override
  void initState() {
    super.initState();
    loadUserEmail();
  }

  Future<void> loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.highLightColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 240,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(top: 86),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      width: 68,
                      height: 68,
                      child: Image.network(userImageUrl),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userEmail,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        // Text(
                        //   userName,
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.person),
                          title: const Text('Hồ sơ'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_view_day_rounded),
                          title: const Text('Lịch khám'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.medical_services),
                          title: const Text('Mua thuốc nhanh'),
                          onTap: () {},
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.shopping_bag),
                          title: const Text('Giỏ hàng'),
                        ),
                      ],
                    ),
                  ),
                  ContainersCustomization.dividerInContainer(),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Cài đặt'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Đăng suất'),
                    onTap: () {
                      _buildShowLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildShowLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Image.asset(
            'assets/icons/sad.png',
            width: 44,
            height: 44,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: AppColors.highLightColor,
          title: const Text(
            'Bạn thật sự muốn đăng xuất?',
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
          content: const Text(
            'Hãy quay trở lại khi cần bạn nhé!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text(
                'Đăng xuất',
                style: TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // void _logout(BuildContext context) {
  //   BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
  // }

  void _logout() async {
    final apiUrl = '${Configs.IP4Local}logout';
    final response = await http.post(
      Uri.parse(apiUrl),
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email'); // Xóa thông tin đăng nhập khỏi SharedPreferences
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ), // Điều hướng về màn hình đăng nhập
      );
    } else {
      // Xử lý lỗi đăng xuất
    }
  }
}
