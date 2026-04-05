import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderRegistrationScreen extends StatefulWidget {
  const GenderRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<GenderRegistrationScreen> createState() =>
      _GenderRegistrationScreenState();
}

class _GenderRegistrationScreenState extends State<GenderRegistrationScreen> {
  Gender _gender = Gender.none;
  bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 45, right: 45, bottom: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              spacing: 20,
              children: <Widget>[
                Image.asset(
                  "assets/authorization_preview/reg_images/fourth_registration_element.jpg",
                  width: 250,
                ),
                Text(
                  "Укажите ваш пол",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                Text(
                  "Некоторые пользователи предпочитают путешествовать с попутчиками определённого пола. Укажите ваш пол для более точного матчинга.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  spacing: 25,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        _gender = Gender.woman;
                        _isFormValid = true;
                      }),
                      child: SvgPicture.asset(
                        "assets/authorization_preview/reg_images/female.svg",
                        width: _gender == Gender.woman ? 120 : 90,
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _gender = Gender.man;
                        _isFormValid = true;
                      }),
                      child: SvgPicture.asset(
                        "assets/authorization_preview/reg_images/male.svg",
                        width: _gender == Gender.man ? 120 : 90,
                      ),
                    ),
                  ],
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
              onTap: () => _isFormValid ? _onNextPressed() : null,
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
    context.read<RegistrationFormBloc>().add(GenderChanged(_gender));
  }

  void _onNextPressed() {
    _sendToBloc();
    Navigator.of(context).pushNamed('registration_hobbies');
  }
}
