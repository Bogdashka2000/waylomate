import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/core/network/models/post_model/model.dart';
import 'package:waylomate/features/main/screens/feed/blocs/post_bloc/post_bloc.dart';

class PostWidget extends StatefulWidget {
  PostWidget({Key? key, required this.postModel}) : super(key: key);

  PostModel postModel;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PostFormBloc>().add(
          GetUserByPostEvent(widget.postModel.userId),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.postModel.isLiked;
    int totalLikes = widget.postModel.likeCount;

    return Container(
      decoration: BoxDecoration(
        // border: BoxBorder.fromBorderSide(
        //   BorderSide(
        //     color: Colors.black,
        //     width: 1.0,
        //     style: BorderStyle.solid,
        //     strokeAlign: 1,
        //   ),
        // ),
      ),
      padding: EdgeInsets.all(8),
      child: BlocBuilder<PostFormBloc, PostFormState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const Center(
              // child: Text("Загрузка поста..."),
              // child: CircularProgressIndicator(
              //   // color: Colors.white,
              //   strokeWidth: 5,
              // ),
            );
          } else if (state is UserLoaded) {
            final isLiked = state.isLiked ?? widget.postModel.isLiked;
            final likeCount = state.totalLikes ?? widget.postModel.likeCount;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "http://${dotenv.env['SERVER']}${state.user.avatarImageUrl}",
                      ),
                      radius: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.user.firstName} ${state.user.lastName}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${widget.postModel.createdAt.hour}:${widget.postModel.createdAt.minute}"
                          " ${widget.postModel.createdAt.day}.${widget.postModel.createdAt.month}.${widget.postModel.createdAt.year}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 12, top: 12),
                  child: Text(widget.postModel.text),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<PostFormBloc>().add(
                          LikeToggleEvent(widget.postModel.Id),
                        );
                      },
                      icon: isLiked
                          ? Icon(Icons.favorite, color: Colors.deepPurple)
                          : Icon(Icons.favorite_border_outlined),
                    ),
                    Text("${likeCount}"),
                    IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                    Text("${widget.postModel.commentCount}"),
                  ],
                ),
              ],
            );
          } else if (state is LoadingPostErrorState) {
            return Center(child: Text("${state.error}"));
          } else {
            return Center(child: Text(""));
          }
        },
      ),
    );
  }
}
