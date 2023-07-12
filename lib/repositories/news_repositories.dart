// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:medical_app/model/news_model.dart';

// class NewsRepository {
//   final CollectionReference newsCollection =
//       FirebaseFirestore.instance.collection('news');

//   Future<List> fetchNews() async {
//     final QuerySnapshot snapshot = await newsCollection.get();
//     return snapshot.docs.map((doc) => NewsModel.fromJson(doc)).toList();
//   }
// }
import 'dart:convert';
import 'package:medical_app/model/news_model.dart';
import 'package:http/http.dart' as http;

import '../config/url_config.dart';

class NewRepositories {
  var url = '${Configs.IP4Local}tintuc';
  var urlID = '${Configs.IP4Local}tintuc/:idloaitintuc';
  Future<List<NewsModel>> fetchNewsList() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      final result = jsonDecode(response.body) as List;
      // print('In DiseaseRepository File: ' + result.toString());
      return result.map((i) => NewsModel.fromJson(i)).toList();
    } else {
      throw 'Error In DiseaseRepository';
    }
  }

  Future<List<NewsModel>> fetchNewsListByType(int typeId) async {
    final response = await http.get(Uri.parse('$urlID?type=$typeId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List;

      return result.map((i) => NewsModel.fromJson(i)).toList();
    } else {
      throw 'Error In NewsRepository';
    }
  }
}
