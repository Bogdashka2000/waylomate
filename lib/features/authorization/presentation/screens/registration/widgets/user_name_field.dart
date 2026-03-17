import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class UsernameRegistrationScreen extends StatelessWidget {
  const UsernameRegistrationScreen({Key? key}) : super(key: key);

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
                  // height: MediaQuery.of(context).size.height * 0.1,
                  scale: 0.2,
                ),
                Form(
                  child: Column(
                    spacing: 15,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Фамилия',
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(Icons.people),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
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
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 126, 87, 194),
                  Color.fromARGB(255, 74, 50, 115),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('registration_birthday');
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
