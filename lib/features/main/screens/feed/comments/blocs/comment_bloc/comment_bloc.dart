import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/comments_repository.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';

part 'comment_bloc_events.dart';
part 'comment_bloc_states.dart';

class CommentFormBloc extends Bloc<CommentFormEvent, CommentFormState> {
  final UserRepository userRepository;
  final CommentRepository commentRepository;
  CommentFormBloc(this.userRepository, this.commentRepository)
    : super(InitialState()) {
    on<GetUserByCommentEvent>(_onGetUserByComment);
  }

  Future<void> _onGetUserByComment(
    GetUserByCommentEvent event,
    Emitter<CommentFormState> emit,
  ) async {
    emit(const LoadingCommentState());

    try {
      final result = await userRepository.getUserById(event.id);
      emit(UserLoaded(result));
    } catch (error) {
      emit(LoadingCommentErrorState(error.toString()));
    }
  }
}
