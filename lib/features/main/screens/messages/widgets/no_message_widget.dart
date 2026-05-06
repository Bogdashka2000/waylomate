import 'package:flutter/material.dart';

class NoMessageWidget extends StatelessWidget {
  const NoMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Нет сообщений', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
