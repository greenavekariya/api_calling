import 'dart:convert';
import 'package:apicalling/getdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeslaNewsScreen extends StatefulWidget {
  const TeslaNewsScreen({super.key});

  @override
  _TeslaNewsScreenState createState() => _TeslaNewsScreenState();
}

class _TeslaNewsScreenState extends State<TeslaNewsScreen> {
  List<dynamic> articles = [];

  Future<void> fetchNews() async {
    // const String apiKey = 'e2be94146e85421d97b5d1c909c3699e';

    final baseKey = "e2be94146e85421d97b5d1c909c3699e";

     String apiUrl =
        'https://newsapi.org/v2/everything?q=tesla&from=2024-02-06&sortBy=publishedAt&apiKey=${baseKey}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        articles = jsonData['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Tesla News'),
        actions: [

          Padding(
            padding: EdgeInsets.only(right: 23),
              child: Icon(Icons.notification_add)),
        ],
      ),

      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            padding:
                const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                      Navigator.push(
                          context,
                        MaterialPageRoute(
                          builder: (context) => NewsViewPage(
                            Data: articles[index]["urlToImage"].toString(),
                              title: articles[index]['title'].toString(),
                          Discription:
                               articles[index]['description'].toString(),
                           ),
                          ),
                         );
                        },
                        child: Image.network(articles[index]["urlToImage"].toString())),
                    const SizedBox(height: 8.0),
                    Text(
                      articles[index]['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsViewPage(
                              Data: articles[index]["urlToImage"].toString(),
                              title: articles[index]['title'].toString(),
                              Discription:
                                  articles[index]['description'].toString(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right:230),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green.withOpacity(0.5),
                          ),
                          width: 120,
                          height: 34,
                          child: const Center(
                            child: Text("Read More"),
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
