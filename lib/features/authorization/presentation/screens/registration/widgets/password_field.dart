import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';

class PasswordRegistrationScreen extends StatefulWidget {
  const PasswordRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<PasswordRegistrationScreen> createState() =>
      _PasswordRegistrationScreenState();
}

class _PasswordRegistrationScreenState
    extends State<PasswordRegistrationScreen> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isFormValid = false;
  bool _showPasswordError = false;
  bool _showConfirmError = false;
  String? _passwordErrorText;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    String? errorText;
    bool isValid = false;

    if (password.isEmpty) {
      errorText = 'Введите пароль';
    } else if (password.length < 8) {
      errorText = 'Минимум 8 символов';
    } else if (confirmPassword.isEmpty) {
      errorText = 'Подтвердите пароль';
    } else if (password != confirmPassword) {
      errorText = 'Пароли не совпадают';
    } else {
      isValid = true;
    }

    setState(() {
      _passwordErrorText = errorText;
      _isFormValid = isValid;
      _showPasswordError = password.isNotEmpty && password.length < 8;
      _showConfirmError =
          confirmPassword.isNotEmpty && password != confirmPassword;
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validateForm);
    _confirmPasswordController.removeListener(_validateForm);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                "assets/authorization_preview/reg_images/password_registration_element.jpg",
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.contain,
              ),
              Form(
                child: Column(
                  spacing: 15,
                  children: [
                    TextField(
                      obscuringCharacter: '•',
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: _showPasswordError
                            ? _passwordErrorText
                            : null,
                        labelText: 'Введите пароль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    TextField(
                      obscuringCharacter: '•',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: _showConfirmError
                            ? _passwordErrorText
                            : null,
                        labelText: 'Подтвердите пароль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.lock_reset),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Создайте пароль",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Text(
                "Запомните его или сохраните в надёжном месте. Если забудете — мы поможем восстановить доступ через email.",
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
              onTap: _isFormValid ? _onNextPressed : null,
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
                  return const Center(
                    child: Text(
                      "ДАЛЕЕ",
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
      PasswordChanged(_passwordController.text.trim()),
    );
  }

  void _onNextPressed() {
    _sendToBloc();
    Navigator.of(context, rootNavigator: false).pushNamed('registration_email');
  }
}
