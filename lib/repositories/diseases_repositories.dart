import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_app/model/diseases_model.dart';
import '../config/url_config.dart';

class DiseaseRepository {
  var url = '${Configs.IP4Local}api/danhsachbenh';

  Future<List<DiseasesModel>> fetchDiseasesList() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      return result.map((i) => DiseasesModel.fromJson(i)).toList();
    } else {
      throw 'Error In DiseaseRepository';
    }
  }

  final String apiUrl = '${Configs.IP4Local}api/timkiembenh';
  Future<List<DiseasesModel>> searchDiseases(String query) async {
    final searchUrl = '$apiUrl?tenbenh=$query';
    // print("Đây là query: " + searchUrl);
    http.Response response = await http.get(Uri.parse(searchUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List;
      return result.map((i) => DiseasesModel.fromJson(i)).toList();
    } else {
      throw 'Error in DiseaseRepository';
    }
  }
}
