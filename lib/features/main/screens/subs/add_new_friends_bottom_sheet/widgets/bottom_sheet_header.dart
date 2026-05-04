import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const Text(
          "Добавить друзей",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}
