import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/main/screens/subs/bloc/subs_bloc.dart';
import 'package:waylomate/features/main/screens/subs/widgets/followed_widget.dart';
import 'package:waylomate/features/main/screens/subs/widgets/followers_widget.dart';
import 'package:waylomate/features/main/screens/subs/widgets/search_people_button.dart';
import 'package:waylomate/features/main/screens/subs/widgets/select_buttons_widget.dart';

class SubsScreen extends StatefulWidget {
  SubsScreen({Key? key, required this.userId}) : super(key: key);
  final int userId;
  @override
  _SubsScreenState createState() => _SubsScreenState();
}

class _SubsScreenState extends State<SubsScreen> {
  bool _isFirst = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SubsFormBloc>().add(GetFollowersAndFollows(widget.userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<SubsFormBloc>().add(
              GetFollowersAndFollows(widget.userId),
            );
          }
        });
      },
      child: BlocBuilder<SubsFormBloc, SubsFormState>(
        builder: (context, state) {
          if (state is LoadingSubsState) {
            return const Center(
              child: CircularProgressIndicator(
                // color: Colors.white,
                strokeWidth: 5,
              ),
            );
          } else if (state is FollowersAndFollowsLoaded) {
            return Column(
              children: [
                SelectButtonsWidget(
                  onChanged: (value) => setState(() {
                    _isFirst = value;
                  }),
                ),
                _isFirst
                    ? FollowedWidget(
                        followed: state.followed,
                        userId: widget.userId,
                      )
                    : FollowersWidget(followers: state.followers),
                SearchPeopleButton(
                  followed: state.followed,
                  userId: widget.userId,
                ),
              ],
            );
          } else if (state is LoadingSubsErrorState) {
            return Center(child: Text("Ошибка подключения к сети"));
          } else {
            return Center(child: Text("Произошла ошибка"));
          }
        },
      ),
    );
  }
}
