import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.actualTitle,
    required this.avatarLink,
  }) : super(key: key);
  final String actualTitle;
  final String avatarLink;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      shadowColor: Colors.white70,
      centerTitle: true,
      toolbarHeight: 80,
      leadingWidth: 64,
      leading: Padding(
        padding: EdgeInsets.only(left: 14),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "http://${dotenv.env['SERVER']}${avatarLink}",
          ),
        ),
      ),
      title: Text(actualTitle),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
