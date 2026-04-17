import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/dio_client.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedIconTheme: IconThemeData(color: Colors.deepPurple),
        selectedLabelStyle: TextStyle(color: Colors.deepPurple),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Лента'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Друзья'),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle, color: Colors.transparent),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Сообщения',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        shape: const CircleBorder(),
        backgroundColor: Color(0xFF7E57C2),
        child: const Icon(Icons.add, size: 36, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: IconButton(
          onPressed: () async {
            final dio = context.read<DioClient>();
            await dio.clearCookies();
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushReplacementNamed('/auth');
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ),
    );
  }
}
