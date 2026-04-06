import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';

class EmailRegistrationScreen extends StatefulWidget {
  const EmailRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<EmailRegistrationScreen> createState() =>
      _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState extends State<EmailRegistrationScreen> {
  late final TextEditingController _emailController;
  bool _showEmailError = false;
  String? _emailErrorText;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(_validateForm);
  }

  void _validateForm() {
    final email = _emailController.text.trim();

    String? errorText;
    bool isValid = false;

    if (email.isEmpty) {
      errorText = 'Введите почту';
    } else if (!email.contains('@')) {
      errorText = 'Почта невалидна';
    } else if (!email.contains('.')) {
      errorText = 'Почта должна содержать точку';
    } else {
      isValid = true;
    }

    setState(() {
      _emailErrorText = errorText;
      _isFormValid = isValid;
      _showEmailError = email.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 55, right: 55, bottom: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            spacing: 15,
            children: <Widget>[
              Image.asset(
                "assets/authorization_preview/reg_images/email_registration_element.png",
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.contain,
              ),
              const Text(
                "Укажите ваш E-mail",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Text(
                "Укажите вашу электронную почту. Это защищает ваш профиль от несанкционированного доступа.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          Form(
            child: Column(
              spacing: 15,
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    errorText: _showEmailError ? _emailErrorText : null,
                    labelText: 'Введите вашу электронную почту',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.mail),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: _isFormValid
                  ? const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 126, 87, 194),
                        Color.fromARGB(255, 74, 50, 115),
                      ],
                    )
                  : const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 130, 130, 130),
                        Color.fromARGB(255, 43, 43, 43),
                      ],
                    ),
            ),
            child: InkWell(
              onTap: (_isFormValid && !(_emailController.text.trim().isEmpty))
                  ? _onNextPressed
                  : null,
              borderRadius: BorderRadius.circular(8),
              child: BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
                builder: (context, state) {
                  if (state is RegistrationFormInProgress &&
                      state.isSubmitting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    );
                  }
                  if (state is RegistrationFormSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(
                        context,
                        rootNavigator: false,
                      ).pushReplacementNamed('/home');
                    });
                    return const Center(
                      child: Text(
                        "✓ Зарегистрирован",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  if (state is RegistrationFormFailure) {
                    return const Center(
                      child: Text(
                        "${}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "ЗАВЕРШИТЬ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendToBloc() {
    context.read<RegistrationFormBloc>().add(
      EmailChanged(_emailController.text.trim()),
    );
  }

  void _onNextPressed() {
    _sendToBloc();
    context.read<RegistrationFormBloc>().add(SendUserData());
  }
}
