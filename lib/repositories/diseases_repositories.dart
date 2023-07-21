import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_app/model/diseases_model.dart';

import '../config/url_config.dart';

class DiseaseRepository {
  var url = '${Configs.IP4Local}danhsachbenh';

  Future<List<DiseasesModel>> fetchDiseasesList() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      // print('In DiseaseRepository File: ' + result.toString());
      return result.map((i) => DiseasesModel.fromJson(i)).toList();
    } else {
      throw 'Error In DiseaseRepository';
    }
  }
}
