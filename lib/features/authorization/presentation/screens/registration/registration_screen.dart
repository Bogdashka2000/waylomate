import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/data/repositories/auth_content_repository.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/observer/observer.dart';
import 'package:waylomate/features/authorization/presentation/router/router.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  late RegistrationNavigatorObserver _observer;
  int _currentStep = 0;
  final int _totalSteps = 9;
  AuthContentRepository acr = AuthContentRepository();

  @override
  void initState() {
    super.initState();
    _observer = RegistrationNavigatorObserver(
      onStepChanged: (step) {
        setState(() => _currentStep = step);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / _totalSteps,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 126, 87, 194),
                ),
                minHeight: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: BlocProvider<RegistrationFormBloc>(
              create: (_) => RegistrationFormBloc(acr),
              child: Navigator(
                initialRoute: 'registration_welcome',
                observers: [_observer],
                onGenerateRoute: router,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
