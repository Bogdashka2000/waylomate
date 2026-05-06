import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/post_bloc/post_bloc.dart';
import 'package:waylomate/features/main/screens/feed/widgets/post_widget.dart';
import 'package:waylomate/features/main/screens/post_creator/post_creator_bloc/post_creator_bloc.dart';
import 'package:waylomate/features/main/screens/post_creator/post_creator_screen.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMaterialModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => BlocProvider<PostCreatorFormBloc>(
            create: (_) => PostCreatorFormBloc(context.read<PostRepository>()),
            child: PostCreatorBottomSheet(),
          ),
        ),
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF7E57C2),
        child: const Icon(Icons.edit, size: 28, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FeedFormBloc>().add(GetPostsEvent());
        },
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
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: .2,
                    color: Colors.grey,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return BlocProvider(
                      create: (_) => PostFormBloc(
                        context.read<UserRepository>(),
                        context.read<PostRepository>(),
                      )..add(GetUserByPostEvent(post.userId)),
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
