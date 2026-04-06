import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';

class AboutRegistrationScreen extends StatefulWidget {
  const AboutRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<AboutRegistrationScreen> createState() =>
      _AboutRegistrationScreenState();
}

class _AboutRegistrationScreenState extends State<AboutRegistrationScreen> {
  late final TextEditingController _aboutController;
  bool _showAboutError = false;
  String? _aboutErrorText;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController();
    _aboutController.addListener(_validateForm);
  }

  void _validateForm() {
    final about = _aboutController.text.trim();

    String? errorText;
    bool isValid = false;

    if (about.isEmpty) {
      errorText = 'Расскажите немного о себе';
    } else if (about.length < 10) {
      errorText = 'Минимум 10 символов';
    } else if (about.length > 500) {
      errorText = 'Максимум 500 символов';
    } else {
      isValid = true;
    }

    setState(() {
      _aboutErrorText = errorText;
      _isFormValid = isValid;
      _showAboutError = about.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _aboutController.removeListener(_validateForm);
    _aboutController.dispose();
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
                "assets/authorization_preview/reg_images/about_registration_element.jpg",
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.contain,
              ),
              const Text(
                "Расскажите о себе",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Text(
                "Коротко опишите свои интересы в путешествиях и кого вы ищете.",
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
                  controller: _aboutController,
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    errorText: _showAboutError ? _aboutErrorText : null,
                    labelText: 'Расскажите о себе',
                    hintText:
                        'Например здесь можно рассказать о том что вы любите есть или какую прочли книгу',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.chat),
                    alignLabelWithHint: true,
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
      AboutChanged(_aboutController.text.trim()),
    );
  }

  void _onNextPressed() {
    _sendToBloc();
    Navigator.of(
      context,
      rootNavigator: false,
    ).pushNamed('registration_password');
  }
}
