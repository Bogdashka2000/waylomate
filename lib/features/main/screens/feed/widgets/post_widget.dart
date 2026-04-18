import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  PostWidget({Key? key}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.fromBorderSide(
          BorderSide(
            color: Colors.black,
            width: 0.2,
            style: BorderStyle.solid,
            strokeAlign: 1,
          ),
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              CircleAvatar(backgroundColor: Colors.black, radius: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Имя Фамилия", style: TextStyle(fontSize: 16)),
                  Text("2 часа назад", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          Text("Текст"),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
              Text("280"),
              IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
              Text("3"),
            ],
          ),
        ],
      ),
    );
  }
}
