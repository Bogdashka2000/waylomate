import 'package:flutter/material.dart';

class RegistrationNavigatorObserver extends NavigatorObserver {
  int actualStep = 0;

  final Function(int) onStepChanged;

  final List<String> _routeNames = [
    'registration_welcome',
    'registration_name',
    'registration_birthday',
    'registration_gender',
    'registration_hobbies',
  ];

  RegistrationNavigatorObserver({required this.onStepChanged});

  _updateStep(String? routeName) {
    if (routeName == null) return;
    final index = _routeNames.indexOf(routeName);

    if (index != -1) {
      actualStep = index;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onStepChanged(index);
      });
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _updateStep(route.settings.name);
  }

  @override
  void didPop(Route route, Route? prevRoute) {
    if (prevRoute != null) _updateStep(prevRoute.settings.name);
  }

  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) _updateStep(newRoute.settings.name);
  }
}
