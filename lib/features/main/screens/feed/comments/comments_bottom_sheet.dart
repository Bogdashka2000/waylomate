import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/comments_repository.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';
import 'package:waylomate/features/main/screens/feed/comments/blocs/comment_bloc/comment_bloc.dart';
import 'package:waylomate/features/main/screens/feed/comments/blocs/comment_list_bloc/comment_list_bloc.dart';
import 'package:waylomate/features/main/screens/feed/comments/widgets/comment_widget.dart';

class CommentBottomSheet extends StatefulWidget {
  CommentBottomSheet({
    Key? key,
    required this.userModel,
    required this.postId,
    required this.postText,
    required this.commentCount,
    required this.createdAt,
  }) : super(key: key);
  final UserModel userModel;
  final int postId;
  final String postText;
  int commentCount;
  final DateTime createdAt;

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  late final TextEditingController _commentController;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();

    _commentController = TextEditingController();
    _commentController.addListener(_validateForm);

    if (widget.commentCount != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<CommentListFormBloc>().add(
            GetCommentsEvent(widget.postId),
          );
        }
      });
    }
  }

  void _validateForm() {
    final comment = _commentController.text.trim();

    setState(() {
      if (comment.isEmpty) {
        _isFormValid = false;
      } else {
        _isFormValid = true;
      }
    });
  }

  @override
  void dispose() {
    _commentController.removeListener(_validateForm);
    _commentController.dispose();
    super.dispose();
  }

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
      // padding: const EdgeInsets.only(top: 30, right: 55, bottom: 55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Text(
                "Комментарии",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 48),
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                "http://${dotenv.env['SERVER']}${widget.userModel.avatarImageUrl}",
              ),
              radius: 24,
            ),
            title: Text(
              "${widget.userModel.firstName} ${widget.userModel.lastName}",
              style: TextStyle(fontSize: 21),
            ),
            subtitle: Text(
              "${widget.createdAt.hour}:${widget.createdAt.minute}"
              " ${widget.createdAt.day}.${widget.createdAt.month}.${widget.createdAt.year}",
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 15, top: 15),
            child: Text(
              widget.postText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: BlocBuilder<CommentListFormBloc, CommentListFormState>(
              builder: (context, state) {
                if (widget.commentCount == 0) {
                  return const Center(child: Text("Комментариев пока нет 😔"));
                }

                if (state is LoadingCommentListState) {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 5),
                  );
                }

                if (state is LoadingCommentListState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      // color: Colors.white,
                      strokeWidth: 5,
                    ),
                  );
                } else if (state is CommentListLoaded) {
                  return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return BlocProvider(
                        create: (_) =>
                            CommentFormBloc(
                              context.read<UserRepository>(),
                              context.read<CommentRepository>(),
                            )..add(
                              GetUserByCommentEvent(
                                state.comments[index].userId,
                              ),
                            ),
                        child: CommentWidget(
                          userId: state.comments[index].userId,
                          text: state.comments[index].text,
                        ),
                      );
                    },
                  );
                } else if (state is CommentListErrorState) {
                  return Center(child: Text("${state.error}"));
                } else {
                  return Center(
                    child: Text(
                      "Произошла ошибка, повторите позже, ${widget.commentCount}",
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Написать комментарий...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                      ),
                      isDense: true,
                    ),
                    maxLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendComment(),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: _isFormValid
                      ? Color.fromARGB(255, 146, 103, 222)
                      : Colors.grey,
                  onPressed: () => _sendComment(),
                  shape: const CircleBorder(),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendComment() {
    print("CLICK");
    if (_isFormValid) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<CommentListFormBloc>().add(
            SendCommentEvent(widget.postId, _commentController.text.trim()),
          );

          setState(() {
            widget.commentCount++;
          });
        }
      });
    }
  }
}
