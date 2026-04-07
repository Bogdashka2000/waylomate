import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/data/repositories/auth_content_repository.dart';
import 'package:waylomate/features/authorization/presentation/blocs/profile_components_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/about_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/email_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/final_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/goals_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/languages_field.dart';
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/password_field.dart';
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
        builder: (context) => UsernameRegistrationScreen(),
        settings: settings,
      );
    case 'registration_birthday':
      return MaterialPageRoute(
        builder: (context) => BirthdayRegistrationScreen(),
        settings: settings,
      );
    case 'registration_gender':
      return MaterialPageRoute(
        builder: (context) => GenderRegistrationScreen(),
        settings: settings,
      );
    case 'registration_hobbies':
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<RegistrationFormBloc>.value(
              value: context.read<RegistrationFormBloc>(),
            ),
            BlocProvider<ProfileComponentsBloc>(
              create: (_) => ProfileComponentsBloc(AuthContentRepository()),
            ),
          ],
          child: const HobbiesRegistrationScreen(),
        ),
        settings: settings,
      );
    case 'registration_goals':
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<RegistrationFormBloc>.value(
              value: context.read<RegistrationFormBloc>(),
            ),
            BlocProvider<ProfileComponentsBloc>(
              create: (_) => ProfileComponentsBloc(AuthContentRepository()),
            ),
          ],
          child: GoalsRegistrationScreen(),
        ),
        settings: settings,
      );
    case 'registration_languages':
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<RegistrationFormBloc>.value(
              value: context.read<RegistrationFormBloc>(),
            ),
            BlocProvider<ProfileComponentsBloc>(
              create: (_) => ProfileComponentsBloc(AuthContentRepository()),
            ),
          ],
          child: LanguagesRegistrationScreen(),
        ),
        settings: settings,
      );
    case 'registration_about':
      return MaterialPageRoute(
        builder: (context) => AboutRegistrationScreen(),
        settings: settings,
      );
    case 'registration_password':
      return MaterialPageRoute(
        builder: (context) => PasswordRegistrationScreen(),
        settings: settings,
      );
    case 'registration_email':
      return MaterialPageRoute(
        builder: (context) => EmailRegistrationScreen(),
        settings: settings,
      );
    case 'registration_final':
      return MaterialPageRoute(
        builder: (context) => const FinalRegistrationScreen(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => PasswordRegistrationScreen(),
        settings: settings,
      );
  }
}
