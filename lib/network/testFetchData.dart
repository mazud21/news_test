import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserList extends StatelessWidget {
  var _keyword = 'keyword';
  var _key = 'e6739a0ecbaa41f6b5f3105ff3ecd10a';
  final url =
      'https://newsapi.org/v2/everything?q=keyword&apiKey=e6739a0ecbaa41f6b5f3105ff3ecd10a';

  //final String apiUrl = "https://randomarticles.me/api/?results=10";

  Future<List<dynamic>> fetcharticless() async {
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body)['articles'];
  }

  String _sourcesId(dynamic articles) {
    return articles['sources']['id'] ?? '-';
  }

  String _sourcesName(dynamic articles) {
    return articles['author']['name'] ?? '-';
  }

  String _author(dynamic articles) {
    return articles['author'] ?? '-';
  }

  String _title(dynamic articles) {
    return articles['title'] ?? '-';
  }

  String _description(dynamic articles) {
    return articles['description'] ?? '-';
  }

  String _url(dynamic articles) {
    return articles['url'] ?? '-';
  }

  String _urlToImage(dynamic articles) {
    return articles['urlToImage'] ?? '-';
  }

  String _publishedAt(dynamic articles) {
    return articles['publishedAt'] ?? '-';
  }

  String _content(dynamic articles) {
    return articles['content'] ?? '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('News List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetcharticless(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {

              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: [
                                Image.network(snapshot.data[index]['urlToImage']
                                    .toString() !=
                                    'null'
                                    ? snapshot.data[index]['urlToImage'].toString()
                                    : 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg'),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: MediaQuery.of(context).size.height * 0.10,
                                    width: MediaQuery.of(context).size.width * 1,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Text(_title(snapshot.data[index]), style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(_publishedAt(snapshot.data[index])),
                          Text(_description(snapshot.data[index])),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CupertinoActivityIndicator(animating: true, radius: 20,));
            }
          },
        ),
      ),
    );
  }
}
