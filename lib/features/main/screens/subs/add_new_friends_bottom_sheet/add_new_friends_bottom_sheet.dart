import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/features/main/screens/subs/add_new_friends_bottom_sheet/bloc/add_new_friends_bloc.dart';
import 'package:waylomate/features/main/screens/subs/add_new_friends_bottom_sheet/widgets/bottom_sheet_header.dart';
import 'package:waylomate/features/main/screens/subs/bloc/subs_bloc.dart';

class AddNewFriendsBottomSheet extends StatefulWidget {
  AddNewFriendsBottomSheet({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  _AddNewFriendsBottomSheetState createState() =>
      _AddNewFriendsBottomSheetState();
}

class _AddNewFriendsBottomSheetState extends State<AddNewFriendsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      height: MediaQuery.of(context).size.height * .9,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(),
          Expanded(
            child: BlocBuilder<AddNewFriendsBloc, AddNewFriendsBlocStates>(
              builder: (context, state) {
                if (state is UserFollowed) {
                  Navigator.of(context).pop();
                  return Center(child: Text(" Лайк поставлен"));
                }

                if (state is LoadingUnfollowedUsersState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      // color: Colors.white,
                      strokeWidth: 5,
                    ),
                  );
                } else if (state is UnfollowedUsersLoaded) {
                  return ListView.builder(
                    itemCount: state.unfollowed.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "http://${dotenv.env['SERVER']}${state.unfollowed[index].avatarImageUrl}",
                                  ),
                                  radius: 24,
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.only(left: 13),
                                  child: Text(
                                    "${state.unfollowed[index].firstName} ${state.unfollowed[index].lastName}",
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
                                context.read<AddNewFriendsBloc>().add(
                                  ToggleToFollow(state.unfollowed[index].id),
                                );
                                context.read<SubsFormBloc>().add(
                                  GetFollowersAndFollows(widget.userId),
                                );
                              },
                              icon: Icon(Icons.person_add_alt, size: 28),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is LoadingUnfollowedUserErrorsState) {
                  return Center(child: Text("Ошибка подключения к сети"));
                } else {
                  return Center(child: Text("Произошла ошибка"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
