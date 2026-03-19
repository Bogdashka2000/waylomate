import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class UsernameRegistrationScreen extends StatefulWidget {
  UsernameRegistrationScreen({Key? key}) : super(key: key);

  @override
  _UsernameRegistrationScreenState createState() =>
      _UsernameRegistrationScreenState();
}

class _UsernameRegistrationScreenState
    extends State<UsernameRegistrationScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  bool _isFormValid = false;
  bool _isFirstNameEmptyAfterTap = false;
  bool _isLastNameEmptyAfterTap = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty;
    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_validateForm);
    _lastNameController.removeListener(_validateForm);
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 55, right: 55, bottom: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              spacing: 20,
              children: <Widget>[
                Image.asset(
                  "assets/authorization_preview/reg_images/second_registration_element.jpg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  scale: 0.2,
                ),
                Form(
                  child: Column(
                    spacing: 15,
                    children: [
                      TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          errorText: _isLastNameEmptyAfterTap
                              ? "Введите фамилию"
                              : null,
                          labelText: 'Фамилия',
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(Icons.people),
                        ),
                      ),
                      TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          errorText: _isFirstNameEmptyAfterTap
                              ? "Введите имя"
                              : null,
                          labelText: 'Имя',
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Как вас зовут?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                Text(
                  "Введите ФИ для создания личного профиля. Это повысит доверие попутчиков к вашим объявлениям.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
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
              onTap: () => _isFormValid
                  ? _onNextPressed()
                  : setState(() {
                      if (_firstNameController.text.trim().isEmpty)
                        _isFirstNameEmptyAfterTap = true;
                      if (_lastNameController.text.trim().isEmpty)
                        _isLastNameEmptyAfterTap = true;
                    }),
              borderRadius: BorderRadius.circular(8),
              child: BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
                builder: (context, state) {
                  if (state is RegistrationFormInProgress) {
                    const Center(
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
      UsernameChanged(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      ),
    );
  }

  void _onNextPressed() {
    _sendToBloc();
    Navigator.of(
      context,
      rootNavigator: false,
    ).pushNamed('registration_birthday');
  }
}
