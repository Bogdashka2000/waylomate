import 'package:flutter/material.dart';
import 'package:waylomate/waylomate_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const WaylomateApp());
}
