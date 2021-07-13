import 'package:flutter/cupertino.dart';
import 'package:news_test/model/model_news.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoadData {
  List<ModelNews> _dataNews = [];

  List<ModelNews> get dataEmployee => _dataNews;

  /*Future<List<ModelNews>> getNews() async {
    var keyword = 'keyword';
    var key = 'e6739a0ecbaa41f6b5f3105ff3ecd10a';
    final url = 'https://newsapi.org/v2/everything?q=$keyword&apiKey=$key';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        _dataNews =
            result.map<ModelNews>((json) => ModelNews.fromJson(json)).toList();

        print("TEST_NEWS0: "+response.body);
        return _dataNews;
      } else {
        return _dataNews;
      }
    } on Exception {
      print("throwing new error");
      throw Exception("Error on server");
    }
  }*/

  Future<ModelNews> getDataNews() async {
    var keyword = 'keyword';
    var key = 'e6739a0ecbaa41f6b5f3105ff3ecd10a';
    final url = 'https://newsapi.org/v2/everything?q=$keyword&apiKey=$key';
    final response = await http.get(Uri.parse(url));

    print("TEST_NEWS1: "+response.body);

    if (response.statusCode == 200) {
      print("TEST_NEWS1_BODY: "+ModelNews.fromJson(json.decode(response.body)).toString());
      return ModelNews.fromJson(json.decode(response.body));
    } else {
      throw Exception('${response.body}');
    }
  }
}
