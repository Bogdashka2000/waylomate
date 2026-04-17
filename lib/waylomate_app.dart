import 'package:flutter/material.dart';
import 'package:waylomate/features/authorization/presentation/screens/authorization_screen.dart';
import 'package:waylomate/features/authorization/presentation/view.dart';
import 'package:waylomate/core/network/repositories/auth_content_repository.dart';
import 'package:waylomate/features/main/main_screen.dart';
import 'package:waylomate/themes/white_theme.dart';
import 'package:waylomate/features/authorization/view/view.dart';

class WaylomateApp extends StatelessWidget {
  const WaylomateApp({super.key, required this.isLogged, required this.acr});
  final bool isLogged;
  final AuthContentRepository acr;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLogged ? '/main' : '/auth',
      title: 'Waylomate',
      theme: white_theme,
      routes: {
        '/main': (context) => MainScreen(),
        '/auth': (context) => AuthorizationScreen(),
        '/registration': (context) => RegistrationWidget(acr: acr),
      },
    );
  }
}
