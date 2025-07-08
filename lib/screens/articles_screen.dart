import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  void fetchArticles() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body).take(10).toList(); // first 10 articles
      });
    } else {
      // error handling
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load articles")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(articles[index]['title']),
                subtitle: Text(articles[index]['body']),
              ),
            ),
    );
  }
}
