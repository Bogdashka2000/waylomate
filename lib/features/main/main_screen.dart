import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';
import 'package:waylomate/features/main/bloc/main_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/feed/feed_screen.dart';
import 'package:waylomate/features/main/screens/messages/messages_screen.dart';
import 'package:waylomate/features/main/screens/post_creator/post_creator_bloc/post_creator_bloc.dart';
import 'package:waylomate/features/main/screens/post_creator/post_creator_screen.dart';
import 'package:waylomate/features/main/screens/profile/profile_screen.dart';
import 'package:waylomate/features/main/screens/subs/bloc/subs_bloc.dart';
import 'package:waylomate/features/main/screens/subs/subs_screen.dart';
import 'package:waylomate/features/main/widgets/main_app_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _navigatorSelectedIndex = 0;

  static List<String> appBarTitles = [
    "Лента",
    "Подписки",
    "",
    "Чат",
    "Профиль",
  ];
  String actualTitle = appBarTitles[0];

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
  Widget build(BuildContext context) {
    return BlocBuilder<MainFormBloc, MainFormState>(
      builder: (context, state) {
        if (state is LoadingMainState) {
          return const Scaffold(
            body: Center(
              child: LinearProgressIndicator(
                // color: Colors.white,
              ),
            ),
          );
        } else if (state is MeLoaded) {
          List<Widget> _screens = [
            FeedScreen(),
            SubsScreen(userId: state.user.id),
            SizedBox.shrink(),
            MessagesScreen(),
            ProfileScreen(),
          ];

          return Scaffold(
            backgroundColor: Colors.white,

            appBar: MainAppBar(
              actualTitle: actualTitle,
              avatarLink: state.user.avatarImageUrl,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              onTap: (index) {
                if (index == 2) return;

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
              selectedIconTheme: IconThemeData(color: Colors.deepPurple),
              selectedLabelStyle: TextStyle(color: Colors.deepPurple),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Лента'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Друзья',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.circle, color: Colors.transparent),
                  label: '',
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
            floatingActionButton: FloatingActionButton(
              onPressed: () => {
                showMaterialModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => BlocProvider<PostCreatorFormBloc>(
                    create: (_) =>
                        PostCreatorFormBloc(context.read<PostRepository>()),
                    child: PostCreatorBottomSheet(),
                  ),
                ),
              },
              shape: const CircleBorder(),
              backgroundColor: Color(0xFF7E57C2),
              child: const Icon(Icons.add, size: 36, color: Colors.white),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: PageView(
              controller: _pageController,
              children: _screens,
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
            body: Center(
              child: CircularProgressIndicator(
                // color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
