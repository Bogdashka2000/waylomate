import 'package:flutter/material.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/welcome_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/user_name_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/birthday_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/gender_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/hobbies_field.dart';

Route? router(RouteSettings settings) {
  switch (settings.name) {
    case 'registration_welcome':
      return MaterialPageRoute(
        builder: (_) => const WelcomeRegistrationScreen(),
        settings: settings,
      );
    case 'registration_name':
      return MaterialPageRoute(
        builder: (_) => const UsernameRegistrationScreen(),
        settings: settings,
      );
    case 'registration_birthday':
      return MaterialPageRoute(
        builder: (_) => const BirthdayRegistrationScreen(),
        settings: settings,
      );
    case 'registration_gender':
      return MaterialPageRoute(
        builder: (_) => const GenderRegistrationScreen(),
        settings: settings,
      );
    case 'registration_hobbies':
      return MaterialPageRoute(
        builder: (_) => const HobbiesRegistrationScreen(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const WelcomeRegistrationScreen(),
        settings: settings,
      );
  }
}
