import 'package:flutter/material.dart';

class WelcomeRegistrationScreen extends StatelessWidget {
  const WelcomeRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 55, right: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              spacing: 20,
              children: <Widget>[
                Image.asset(
                  "assets/authorization_preview/reg_images/first_registration_element.jpg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  scale: 0.2,
                ),
                Text(
                  "Устали путешествовать в одиночестве?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                Text(
                  "Наше приложение соединяет путешественников по всему миру. Найдите попутчика, который разделит ваши интересы и сделает поездку незабываемой.",
                  textAlign: TextAlign.justify,
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
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 126, 87, 194),
                  Color.fromARGB(255, 74, 50, 115),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('registration_name');
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
