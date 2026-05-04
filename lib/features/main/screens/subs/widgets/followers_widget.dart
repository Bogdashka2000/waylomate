import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';

class FollowersWidget extends StatefulWidget {
  FollowersWidget({Key? key, required this.followers}) : super(key: key);
  List<UserModel> followers;
  @override
  _FollowersWidgetState createState() => _FollowersWidgetState();
}

class _FollowersWidgetState extends State<FollowersWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.followers.isEmpty) {
      return Expanded(child: Center(child: Text("Пока подписчиков нет :(")));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: widget.followers.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://${dotenv.env['SERVER']}${widget.followers[index].avatarImageUrl}",
                  ),
                  radius: 24,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 13),
                  child: Text(
                    "${widget.followers[index].firstName} ${widget.followers[index].lastName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
