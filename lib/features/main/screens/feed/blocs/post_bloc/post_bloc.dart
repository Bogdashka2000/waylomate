import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/like_model/model.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';

part 'post_bloc_events.dart';
part 'post_bloc_states.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  final PostRepository postRepository;
  PostFormBloc(this.postRepository) : super(InitialState()) {
    on<GetUserByPostEvent>(_onGetUserByPost);
    on<LikeToggleEvent>(_onToggleLike);
  }

  Future<void> _onGetUserByPost(
    GetUserByPostEvent event,
    Emitter<PostFormState> emit,
  ) async {
    emit(const LoadingPostState());

    try {
      final result = await postRepository.getUserFromPost(event.id);
      emit(UserLoaded(result, null, null));
    } catch (error) {
      emit(LoadingPostErrorState(error.toString()));
    }
  }

  Future<void> _onToggleLike(
    LikeToggleEvent event,
    Emitter<PostFormState> emit,
  ) async {
    // 🔹 Не эмитим LoadingPostState если не нужно показывать лоадер на весь пост

    try {
      final likeResult = await postRepository.likeToggle(event.postId);
      if (state is UserLoaded) {
        final updatedUser = (state as UserLoaded).user;
        emit(
          UserLoaded(updatedUser, likeResult.isLiked, likeResult.totalLikes),
        );
      } else {
        emit(IsLikeToggeled(likeResult));
      }
    } catch (error) {
      emit(LoadingPostErrorState(error.toString()));
    }
  }
}
