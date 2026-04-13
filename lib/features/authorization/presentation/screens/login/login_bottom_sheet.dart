import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/login_sheet_bloc/bloc.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isFormValid = false;
  bool _showEmailError = false;
  bool _showPasswordError = false;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    String? emailError;
    String? passwordError;
    bool isValid = false;

    if (email.isEmpty) {
      emailError = 'Введите email';
    } else if (!email.contains('@')) {
      emailError = 'Почта невалидна';
    } else if (!email.contains('.')) {
      emailError = 'Почта должна содержать точку';
    }

    if (password.isEmpty) {
      passwordError = 'Введите пароль';
    } else if (password.length < 8) {
      passwordError = 'Минимум 6 символов';
    }

    isValid = emailError == null && passwordError == null;

    setState(() {
      _emailErrorText = emailError;
      _passwordErrorText = passwordError;
      _isFormValid = isValid;
      _showEmailError = email.isNotEmpty;
      _showPasswordError = password.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state is LoginValidState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushReplacementNamed('/');
          });
        }
        if (state is LoginErrorState) {
          setState(() {
            // _emailErrorText = state.error;
            _emailErrorText = "Неверная почта или пароль";
            _showEmailError = true;
          });
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 30,
          left: 55,
          right: 55,
          bottom: 55,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              spacing: 20,
              children: <Widget>[
                Image.asset(
                  "assets/authorization_preview/login_images/login.jpg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.contain,
                ),
                const Text(
                  "Мы по вам очень скучали",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const Text(
                  "Рады видеть вас снова! Войдите в аккаунт, чтобы продолжить публикацию маршрутов и общение с попутчиками.",
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
                    decoration: InputDecoration(
                      errorText: _showEmailError ? _emailErrorText : null,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.mail),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: _showPasswordError ? _passwordErrorText : null,
                      labelText: 'Пароль',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock),
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
                child: BlocBuilder<LoginFormBloc, LoginFormState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    }

                    if (state is LoginValidState) {
                      return const Center(
                        child: Text(
                          "✓ Войти",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    if (state is LoginErrorState) {
                      return const Center(
                        child: Text(
                          "↻ Повторить",
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
                        "ВОЙТИ",
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
      ),
    );
  }

  void _onNextPressed() {
    context.read<LoginFormBloc>().add(
      LoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }
}
