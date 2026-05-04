import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/features/main/screens/subs/bloc/subs_bloc.dart';

class FollowedWidget extends StatefulWidget {
  FollowedWidget({Key? key, required this.followed, required this.userId})
    : super(key: key);
  List<UserModel> followed;
  int userId;
  @override
  _FollowedWidgetState createState() => _FollowedWidgetState();
}

class _FollowedWidgetState extends State<FollowedWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.followed.isEmpty) {
      return Expanded(child: Center(child: Text("Пока подписок нет :(")));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: widget.followed.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "http://${dotenv.env['SERVER']}${widget.followed[index].avatarImageUrl}",
                      ),
                      radius: 24,
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 13),
                      child: Text(
                        "${widget.followed[index].firstName} ${widget.followed[index].lastName}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    context.read<SubsFormBloc>().add(
                      ToggleToUnfollow(widget.followed[index].id),
                    );
                    context.read<SubsFormBloc>().add(
                      GetFollowersAndFollows(widget.userId),
                    );
                  },
                  icon: Icon(Icons.person_remove_outlined, size: 28),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
