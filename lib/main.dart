import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final String apiUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_API_KEY";
  List articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body)['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter News App'),
      ),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                article['urlToImage'] != null
                    ? Image.network(article['urlToImage'])
                    : SizedBox.shrink(),
                ListTile(
                  title: Text(article['title']),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(article['publishedAt'])),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(article['description'] ?? ''),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
