import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;


class NewsViewPage extends StatefulWidget {
  final  String Data;
 final String?  title;
 final String?  Discription;
  const NewsViewPage({Key? key, required this.Data, required this.title, required this.Discription}) : super(key: key);

  @override
  State<NewsViewPage> createState() => _NewsViewPageState();
}

class _NewsViewPageState extends State<NewsViewPage> {
  List<dynamic> articles = [];

  Future<void> Fetchheader() async {
    // const String apiKey = 'e2be94146e85421d97b5d1c909c3699e';

    final baseKey = "e2be94146e85421d97b5d1c909c3699e";

    String apiUrl =
        'https://newsapi.org/v2/everything?q=keyword&apiKey=${baseKey}';

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
    // TODO: implement initState
    super.initState();
    Fetchheader();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue,
            expandedHeight: 500.0,
            pinned: true,
            floating: true,
            elevation: 20,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(right: 10),
                  child: Text(widget.title!,style: TextStyle(
                       fontSize: 12,fontWeight: FontWeight.bold),)),
              background: Image.network(
                 widget.Data,
                fit: BoxFit.fill,
              ),
            ),
          ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Text(widget.Discription!),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 200),
                      child: Text("Breaking News",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                          fontSize: 21),
                      ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GridView.count(crossAxisCount: 6,
                      children: [
                        Image.network(articles[index]['urlToImage'].toString()),

                      ],
                    ),
                  )
                ],
              ),
              )
            );
          },
          childCount: 1,
          ),
         )
        ],
      ),

    );
  }
}
