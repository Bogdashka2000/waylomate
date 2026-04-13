import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/data/repositories/auth_content_repository.dart';
import 'package:waylomate/features/authorization/presentation/blocs/login_sheet_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:waylomate/waylomate_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");

  final acr = AuthContentRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginFormBloc>(create: (_) => LoginFormBloc(acr)),
        BlocProvider<RegistrationFormBloc>(
          create: (_) => RegistrationFormBloc(acr),
        ),
      ],
      child: const WaylomateApp(),
    ),
  );
}
