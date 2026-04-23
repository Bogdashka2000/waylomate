import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/features/main/screens/feed/comments/blocs/comment_bloc/comment_bloc.dart';

class CommentWidget extends StatefulWidget {
  CommentWidget({Key? key, required this.userId, required this.text})
    : super(key: key);
  final int userId;
  final String text;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentFormBloc, CommentFormState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return ListTile(
            // internalAddSemanticForOnTap: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                "http://${dotenv.env['SERVER']}${state.user.avatarImageUrl}",
              ),
            ),
            title: Text("${state.user.firstName} ${state.user.lastName}"),
            subtitle: Text(widget.text),
          );
        } else {
          return Container(child: Text(""));
        }
      },
    );
  }
}
