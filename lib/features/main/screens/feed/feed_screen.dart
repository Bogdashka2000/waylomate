import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/post_bloc/post_bloc.dart';
import 'package:waylomate/features/main/screens/feed/widgets/post_widget.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FeedFormBloc>().add(GetPostsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FeedFormBloc>().add(GetPostsEvent());
      },
      child: Container(
        child: BlocBuilder<FeedFormBloc, FeedFormState>(
          builder: (context, state) {
            if (state is LoadingFeedState) {
              return const Center(
                child: CircularProgressIndicator(
                  // color: Colors.white,
                  strokeWidth: 5,
                ),
              );
            } else if (state is PostLoaded) {
              print(state.posts.length);
              return Container(
                child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return BlocProvider(
                      create: (_) =>
                          PostFormBloc(context.read<PostRepository>())
                            ..add(GetUserByPostEvent(post.userId)),
                      child: PostWidget(postModel: post),
                    );
                  },
                ),
              );
            } else if (state is LoadingFeedErrorState) {
              return Center(child: Text("${state.error}"));
            } else {
              return Center(child: Text("Произошла ошибка, повторите позже"));
            }
          },
        ),
      ),
    );
  }
}
