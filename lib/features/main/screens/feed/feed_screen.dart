import 'package:flutter/material.dart';
import 'package:waylomate/features/main/screens/feed/widgets/post_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return PostWidget();
        },
      ),
    );
  }
}
