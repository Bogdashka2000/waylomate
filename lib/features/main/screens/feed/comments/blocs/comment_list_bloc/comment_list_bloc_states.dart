part of 'comment_list_bloc.dart';

abstract class CommentListFormState extends Equatable {
  const CommentListFormState();
  List<Object?> get props => [];
}

class InitialCommentListState extends CommentListFormState {
  const InitialCommentListState();
}

class LoadingCommentListState extends CommentListFormState {
  const LoadingCommentListState();
}

class CommentListLoaded extends CommentListFormState {
  final List<CommentModel> comments;
  const CommentListLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentListErrorState extends CommentListFormState {
  final String error;
  const CommentListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
