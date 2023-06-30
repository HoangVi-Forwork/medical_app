import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/model/department_model.dart';

class DepartmentRepository {
  var url = 'http://172.19.200.140:5090/khoabenh';
  Future<List<DepartmentModel>> getDepartment() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      print(result);
      return result.map((i) => DepartmentModel.fromJson(i)).toList();
    } else {
      throw 'Error in DepartmentRepository';
    }
  }
}
