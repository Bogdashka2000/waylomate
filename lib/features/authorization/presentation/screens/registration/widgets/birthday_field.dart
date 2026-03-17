import 'package:flutter/material.dart';

class BirthdayRegistrationScreen extends StatefulWidget {
  const BirthdayRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<BirthdayRegistrationScreen> createState() =>
      _BirthdayRegistrationScreenState();
}

class _BirthdayRegistrationScreenState
    extends State<BirthdayRegistrationScreen> {
  DateTime? _selectedDate;

  final List<String> _months = [
    "Января",
    "Февраля",
    "Марта",
    "Апреля",
    "Мая",
    "Июня",
    "Июля",
    "Августа",
    "Сентября",
    "Октября",
    "Ноября",
    "Декабря",
  ];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(), // Нельзя выбрать дату в будущем
    );

    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
                  "assets/authorization_preview/reg_images/third_registration_element.jpg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  scale: 0.2,
                ),
                Text(
                  "Укажите дату рождения",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                Text(
                  "Указание даты рождения помогает создать безопасное сообщество путешественников.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () => _pickDate(),

                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              _selectedDate != null
                                  ? '${_selectedDate?.day.toString()}'
                                  : '',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Text("День"),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => _pickDate(),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              _selectedDate != null
                                  ? '${_months[_selectedDate!.month - 1]}'
                                  : '',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Text("Месяц"),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => _pickDate(),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              _selectedDate != null
                                  ? '${_selectedDate?.year.toString()}'
                                  : '',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Text("Год"),
                      ],
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
                Navigator.of(context).pushNamed('registration_gender');
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
