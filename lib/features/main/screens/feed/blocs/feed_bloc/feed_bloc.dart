import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/post_model/model.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';

part 'feed_bloc_events.dart';
part 'feed_bloc_states.dart';

class FeedFormBloc extends Bloc<FeedFormEvent, FeedFormState> {
  final PostRepository postRepository;
  FeedFormBloc(this.postRepository) : super(InitialState()) {
    on<GetPostsEvent>(_onGetPosts);
  }

  Future<void> _onGetPosts(
    GetPostsEvent event,
    Emitter<FeedFormState> emit,
  ) async {
    emit(const LoadingFeedState());

    try {
      final result = await postRepository.getPosts();
      emit(PostLoaded(result));
    } catch (error) {
      emit(LoadingFeedErrorState(error.toString()));
    }
  }
}
