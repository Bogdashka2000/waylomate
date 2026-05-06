import 'package:flutter/material.dart';
import 'package:waylomate/core/network/models/news_model/news_model.dart';

class NewsReader extends StatelessWidget {
  const NewsReader({Key? key, required this.newsModel}) : super(key: key);

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            spacing: 20,
            children: [
              Text(
                newsModel.title,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                newsModel.text,
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
