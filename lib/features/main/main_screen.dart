import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/main/bloc/main_bloc.dart';
import 'package:waylomate/features/main/screens/feed/feed_screen.dart';
import 'package:waylomate/features/main/screens/messages/messages_screen.dart';
import 'package:waylomate/features/main/screens/news/news_screen.dart';
import 'package:waylomate/features/main/screens/profile/profile_screen.dart';
import 'package:waylomate/features/main/screens/subs/subs_screen.dart';
import 'package:waylomate/features/main/widgets/main_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key}); // 🔹 Современный синтаксис

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _navigatorSelectedIndex = 0;

  static const List<String> appBarTitles = [
    "Лента",
    "Подписки",
    "Новости",
    "Чат",
    "Профиль",
  ];
  String actualTitle = appBarTitles[0];

  final List<Widget> _staticScreens = [FeedScreen()];
  List<Widget>? _cachedScreens; // 🔹 КЭШ: экраны создаются 1 раз

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MainFormBloc>().add(GetMe());
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainFormBloc, MainFormState>(
      builder: (context, state) {
        if (state is LoadingMainState) {
          return const Scaffold(body: Center(child: LinearProgressIndicator()));
        } else if (state is MeLoaded) {
          _cachedScreens ??= [
            _staticScreens[0],
            SubsScreen(userId: state.user.id),
            NewsScreen(),
            MessagesScreen(userId: state.user.id),
            ProfileScreen(userModel: state.user, addBack: false),
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _navigatorSelectedIndex != 4
                ? MainAppBar(
                    actualTitle: actualTitle,
                    avatarLink: state.user.avatarImageUrl,
                  )
                : null,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _navigatorSelectedIndex = index;
                  actualTitle = appBarTitles[index];
                  _pageController.animateToPage(
                    _navigatorSelectedIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                });
              },
              currentIndex: _navigatorSelectedIndex,
              showUnselectedLabels: false,
              iconSize: 30,
              selectedIconTheme: const IconThemeData(color: Colors.deepPurple),
              selectedLabelStyle: const TextStyle(color: Colors.deepPurple),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Лента'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Друзья',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'Новости',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Сообщения',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Профиль',
                ),
              ],
            ),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _cachedScreens!, // 🔹 Используем закэшированный список
              onPageChanged: (index) {
                setState(() => _navigatorSelectedIndex = index);
              },
            ),
          );
        } else if (state is LoadingMainErrorState) {
          return const Scaffold(
            body: Center(child: Text("Ошибка подключения к серверу")),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
