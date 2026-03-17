import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderRegistrationScreen extends StatefulWidget {
  const GenderRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<GenderRegistrationScreen> createState() =>
      _GenderRegistrationScreenState();
}

enum Gender { woman, man, none }

class _GenderRegistrationScreenState extends State<GenderRegistrationScreen> {
  Gender _gender = Gender.none;

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
                  width: MediaQuery.of(context).size.width * 0.5,
                  scale: 0.2,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        _gender = Gender.woman;
                      }),
                      child: SvgPicture.asset(
                        "assets/authorization_preview/reg_images/female.svg",
                        width: _gender == Gender.woman ? 150 : 100,
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _gender = Gender.man;
                      }),
                      child: SvgPicture.asset(
                        "assets/authorization_preview/reg_images/male.svg",
                        width: _gender == Gender.man ? 150 : 110,
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
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 126, 87, 194),
                  Color.fromARGB(255, 74, 50, 115),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('registration_hobbies');
              },
              borderRadius: BorderRadius.circular(8),
              child: const Center(
                child: Text(
                  "ДАЛЕЕ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
