import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/post_bloc/post_bloc.dart';
import 'package:waylomate/features/main/screens/post_creator/post_creator_bloc/post_creator_bloc.dart';

class PostCreatorBottomSheet extends StatefulWidget {
  PostCreatorBottomSheet({Key? key}) : super(key: key);

  @override
  _PostCreatorBottomSheetState createState() => _PostCreatorBottomSheetState();
}

class _PostCreatorBottomSheetState extends State<PostCreatorBottomSheet> {
  late final TextEditingController _postController;
  bool _isValid = false;
  @override
  void initState() {
    super.initState();

    _postController = TextEditingController();
    _postController.addListener(_validateForm);
  }

  void _validateForm() {
    final comment = _postController.text.trim();
    setState(() {
      if (comment.isNotEmpty) {
        _isValid = true;
      } else {
        _isValid = false;
      }
    });
  }

  @override
  void dispose() {
    _postController.removeListener(_validateForm);
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Напишите пост"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.all(21),
              child: TextField(
                controller: _postController,
                decoration: InputDecoration(
                  hintText: 'Здесь будет ваш текст!',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    if (_isValid) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          context.read<PostCreatorFormBloc>().add(
                            SendPostEvent(_postController.text.trim()),
                          );
                        }
                      });
                    }
                  },
                  shape: const CircleBorder(),
                  backgroundColor: _isValid ? Color(0xFF7E57C2) : Colors.grey,
                  child: BlocBuilder<PostCreatorFormBloc, PostCreatorFormState>(
                    builder: (context, state) {
                      if (state is LoadingPostCreatorState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 5,

                            color: Colors.white,
                          ),
                        );
                      } else if (state is PostSended) {
                        Navigator.of(context).pop();
                        return const Icon(Icons.check, color: Colors.white);
                      } else if (state is LoadingPostCreatorErrorState) {
                        return const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        );
                      } else {
                        return const Icon(Icons.send, color: Colors.white);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
