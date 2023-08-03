// ignore_for_file: unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/views/auth/sign_in/sign_in_screen.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/container_config/container_customization.dart';

import '../blocs/auth/auth_bloc.dart';

// ignore: camel_case_types
class buildDrawer extends StatelessWidget {
  const buildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // LOGOUT FUNC

    void _logout(BuildContext context) {
      BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
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
                  // _logout(context);
                  // Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                      fullscreenDialog: true,
                    ),
                  );
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

    return Drawer(
      backgroundColor: AppColors.highLightColor,
      child: Column(
        children: [
          // TOP INFOMATIONS
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
                      // margin: const EdgeInsets.only(bottom: 0),
                      child: Image.network(
                        'https://i.pinimg.com/564x/ec/fd/c0/ecfdc07b30149c927956fe5bb6126e2c.jpg',
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Nguyen Hoang Vi",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "0907656399",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print('Okey, Click cai qq');
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          // FUNC ICONS
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
                          onTap: () {
                            print('Okey, Click cai qq');
                          },
                          leading: const Icon(Icons.shopping_bag),
                          title: const Text(
                            'Giỏ hàng',
                          ),
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
}
