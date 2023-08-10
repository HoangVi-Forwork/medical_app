import 'dart:convert';
import 'package:medical_app/model/user_info_model.dart';
import 'package:medical_app/model/user_model_copy.dart';
import 'package:http/http.dart' as http;
import '../config/url_config.dart';

class UserRepository {
  final String url = '${Configs.IP4Local}api/user';
  Future<List<UserModel_Copy>> fetchUsers(String query) async {
    final searchUrl = '$url?email=$query';
    http.Response response = await http.get(Uri.parse(searchUrl));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      return result.map((i) => UserModel_Copy.fromJson(i)).toList();
    } else {
      throw 'Error In UserRepository';
    }
  }

  Future<List<UserModel_Copy>> fetchUsersID(String query) async {
    final searchUrl = '$url?id=$query';
    print(searchUrl);
    http.Response response = await http.get(Uri.parse(searchUrl));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      print(result);
      return result.map((i) => UserModel_Copy.fromJson(i)).toList();
    } else {
      throw 'Error In UserRepository';
    }
  }

  Future<List<UserInfoModel>> fetchUserInfo(String query) async {
    final searchUrl = '$url?id=$query';
    http.Response response = await http.get(Uri.parse(searchUrl));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      return result.map((i) => UserInfoModel.fromJson(i)).toList();
    } else {
      throw 'Error In UserRepository';
    }
  }

  final String urlUpdate = '${Configs.IP4Local}api/user/update';
  Future<void> updateUser(UserModel_Copy user, UserInfoModel userInfo) async {
    final updateUrl = '$url/${user.id}';
    final Map<String, dynamic> userData = {
      'email': user.email,
      'password': user.password,
      'setpassword': user.setpassword,
      'ten': user.ten,
      'sdt': userInfo.phone,
      'diachi': userInfo.address,
      'avatar': userInfo.avata,
      'sex': userInfo.sex,
    };

    final response =
        await http.put(Uri.parse(updateUrl), body: jsonEncode(userData));

    if (response.statusCode == 200) {
      print('User information updated successfully.');
    } else {
      throw 'Error updating user information';
    }
  }
}
