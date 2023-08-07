import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/blocs/user/bloc/user_bloc.dart';
import 'package:medical_app/model/user_model_copy.dart';
import 'package:medical_app/repositories/user_repositories.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/container_utils.dart';
import '../../widgets/buttons/floating_scroll_button.dart';

class UserProfileScreen extends StatefulWidget {
  // final String? userEmail;
  final int? userID;
  UserProfileScreen({super.key, this.userID});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late UserBloc _userBloc;
  String userEmail = "";
  late int? userID;
  bool isVisibale = false;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(UserRepository());
    checkUserID();
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

  void checkUserID() async {
    final userID = await loadUserID();
    print("Thêm vào $userID");
    _userBloc.add(UserFetchId(userID));
  }

  Future<int> loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userID = prefs.getInt('id') ?? 0;
    print("Lấy được $userID");
    return userID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Hồ sơ'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
          bloc: _userBloc,
          builder: ((context, state) {
            if (state is UserLoading) {
              return ContainerUtils.loadingStateContainer0;
            } else if (state is UserLoadError) {
              return ContainerUtils.loadingErrorStateContainer; //
            } else if (state is UserLoadedID) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final userInfor = state.users[index];
                  final userInformation = state.userInformation[index];
                  final postionType = userInfor.quyenhan;
                  final sex = userInformation.sex;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: postionType == '1'
                              ? const Text(
                                  'Người dùng cá nhân',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                )
                              : const Text(
                                  'Quản lý',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.highLightColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              userInformation.avata.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            userInfor.ten.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                        buildUserRowButton(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Thông tin (#${userInfor.id}):',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              buildRowUserInfo(
                                  '✉️ : ', userInfor.email.toString()),
                              buildRowUserInfo(
                                  '👤 : ', userInfor.ten.toString()),
                              buildRowUserInfo(
                                  '🏠 : ', userInformation.address.toString()),
                              buildRowUserInfo(
                                  '☎️ : ', userInformation.phone.toString()),
                              buildRowUserInfo(
                                  '⚧️ : ', sex == 1 ? 'Nam' : 'Nữ'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          })),
      floatingActionButton: BuildFloatingActionScrollButton(
        isVisibale: isVisibale,
        scrollController: scrollController,
      ),
    );
  }

  Container buildRowUserInfo(String tile, String userInfor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Text(tile),
                ),
                Text(
                  userInfor,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }

  Container buildUserRowButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 58),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    "Sửa thông tin",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    "Liên hệ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
