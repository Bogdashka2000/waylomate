import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';
import 'package:waylomate/features/main/screens/subs/add_new_friends_bottom_sheet/add_new_friends_bottom_sheet.dart';
import 'package:waylomate/features/main/screens/subs/add_new_friends_bottom_sheet/bloc/add_new_friends_bloc.dart';

class SearchPeopleButton extends StatefulWidget {
  SearchPeopleButton({Key? key, required this.followed, required this.userId})
    : super(key: key);
  final followed;
  final int userId;

  @override
  _SearchPeopleButtonState createState() => _SearchPeopleButtonState();
}

class _SearchPeopleButtonState extends State<SearchPeopleButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(18),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Color(0xFF7E57C2),
            onPressed: () {
              showMaterialModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => BlocProvider(
                  create: (_) =>
                      AddNewFriendsBloc(context.read<UserRepository>())
                        ..add(GetUnfollowedUsers(widget.followed)),
                  child: AddNewFriendsBottomSheet(userId: widget.userId),
                ),
              );
            },
            child: Icon(
              Icons.group_add_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
