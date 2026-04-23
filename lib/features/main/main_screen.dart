import 'package:flutter/material.dart';
import 'package:waylomate/features/main/screens/feed/feed_screen.dart';
import 'package:waylomate/features/main/screens/messages/messages_screen.dart';
import 'package:waylomate/features/main/screens/post_creator/post_creator_screen.dart';
import 'package:waylomate/features/main/screens/profile/profile_screen.dart';
import 'package:waylomate/features/main/screens/subs/subs_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _navigatorSelectedIndex = 0;

  final List<Widget> _screens = [
    FeedScreen(),
    SubsScreen(),
    PostCreatorScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        leadingWidth: 64,
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: 14),
          child: CircleAvatar(backgroundColor: Colors.black),
        ),
        title: Text("Лента"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          _navigatorSelectedIndex = index;
          _pageController.animateToPage(
            _navigatorSelectedIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }),
        currentIndex: _navigatorSelectedIndex,
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
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() => _navigatorSelectedIndex = index);
        },
      ),
    );
  }
}
