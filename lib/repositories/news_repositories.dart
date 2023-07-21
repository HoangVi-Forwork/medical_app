import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_app/model/news_model.dart';
import '../config/url_config.dart';

class NewRepositories {
  final String url = '${Configs.IP4Local}api/tintuc';

  Future<List<NewsModel>> fetchNewsList() async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      return result.map((i) => NewsModel.fromJson(i)).toList();
    } else {
      throw 'Error In DiseaseRepository';
    }
  }

  Future<List<NewsModel>> fetchNewsListByType(int typeId) async {
    final response =
        await http.get(Uri.parse('$url/$typeId')); // Update the endpoint URL
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List;
      return result.map((i) => NewsModel.fromJson(i)).toList();
    } else {
      throw 'Error In NewsRepository';
    }
  }
}
