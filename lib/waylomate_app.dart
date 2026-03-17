import 'package:flutter/material.dart';
import 'package:waylomate/features/authorization/presentation/screens/authorization_screen.dart';
import 'package:waylomate/features/authorization/presentation/view.dart';

import 'package:waylomate/themes/white_theme.dart';
import 'package:waylomate/features/authorization/view/view.dart';

class WaylomateApp extends StatelessWidget {
  const WaylomateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waylomate',
      theme: white_theme,
      routes: {
        '/': (context) => AuthorizationScreen(),
        '/registration': (context) => RegistrationWidget(),
      },
    );
  }
}
