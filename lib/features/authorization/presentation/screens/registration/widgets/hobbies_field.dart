import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waylomate/features/authorization/presentation/blocs/profile_components_bloc/bloc.dart'
    hide State;
import 'package:waylomate/features/authorization/presentation/screens/registration/widgets/hobby_alert.dart';

class HobbiesRegistrationScreen extends StatefulWidget {
  const HobbiesRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<HobbiesRegistrationScreen> createState() =>
      _HobbiesRegistrationScreenState();
}

class _HobbiesRegistrationScreenState extends State<HobbiesRegistrationScreen> {
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
                  "assets/authorization_preview/reg_images/hobbies_registration_element.jpg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  scale: 0.2,
                ),
                const Text(
                  "Расскажите о своих увлечениях",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const Text(
                  "Так система подберёт спутников, с которыми вам будет комфортно в дороге. Общие интересы делают поездку приятнее!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 126, 87, 194),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () => {
                          showDialog<void>(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<ProfileComponentsBloc>(),
                              child: HobbyAlert(),
                            ),
                          ),
                        },
                        icon: Icon(
                          Icons.add,
                          size: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
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
                Navigator.of(context).pop();
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
