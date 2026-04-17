import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waylomate/features/authorization/presentation/blocs/login_sheet_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/screens/login/login_bottom_sheet.dart';

class AuthorizationScreen extends StatefulWidget {
  AuthorizationScreen({Key? key}) : super(key: key);

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/authorization_preview/welcome_background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.bottomCenter,
                child: Column(
                  spacing: 18.0,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/authorization_preview/logo_with_colors.svg",
                      width: 100,
                    ),

                    Text(
                      "ПУТЕШЕСТВУЙ С НАМИ",
                      textAlign: TextAlign.center,

                      // style: GoogleFonts.robotoFlex(
                      //   fontSize: 36,
                      //   color: Colors.white,
                      // ),
                      style: TextStyle(
                        height: 1.2,
                        fontFamily: "Roboto Flex",
                        fontVariations: [FontVariation('wght', 1000)],
                        fontSize: 36,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Создавайте маршруты, находите единомышленников и исследуйте мир без одиночества",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  spacing: 16,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 42),
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
                          showMaterialModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) =>
                                BlocProvider<LoginFormBloc>.value(
                                  value: context.read<LoginFormBloc>(),
                                  child: const LoginBottomSheet(),
                                ),
                          );
                        },

                        borderRadius: BorderRadius.circular(8),
                        child: const Center(
                          child: Text(
                            "ВОЙТИ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 42),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 219, 199, 255),
                      ),

                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed("/registration"),
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(
                          child: Text(
                            "ЗАРЕГИСТРИРОВАТЬСЯ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 75, 75, 75),
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
