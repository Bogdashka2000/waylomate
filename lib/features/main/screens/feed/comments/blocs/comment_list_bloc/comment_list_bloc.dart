import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/comment_model/model.dart';
import 'package:waylomate/core/network/repositories/comments_repository.dart';

part 'comment_list_bloc_events.dart';
part 'comment_list_bloc_states.dart';

class CommentListFormBloc
    extends Bloc<CommentListFormEvent, CommentListFormState> {
  final CommentRepository commentRepository;
  CommentListFormBloc(this.commentRepository)
    : super(InitialCommentListState()) {
    on<GetCommentsEvent>(_onGetComments);
    on<SendCommentEvent>(_onSendComment);
  }

  Future<void> _onGetComments(
    GetCommentsEvent event,
    Emitter<CommentListFormState> emit,
  ) async {
    emit(const LoadingCommentListState());

    try {
      final result = await commentRepository.getCommentsByPostId(event.postId);
      emit(CommentListLoaded(result));
    } catch (error) {
      emit(CommentListErrorState(error.toString()));
    }
  }

  Future<void> _onSendComment(
    SendCommentEvent event,
    Emitter<CommentListFormState> emit,
  ) async {
    emit(const LoadingCommentListState());

    try {
      await commentRepository.sendComment(event.postId, event.text);
      final result = await commentRepository.getCommentsByPostId(event.postId);
      emit(CommentListLoaded(result));
    } catch (error) {
      emit(CommentListErrorState(error.toString()));
    }
  }
}
