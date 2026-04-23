part of 'comment_bloc.dart';

abstract class CommentFormState extends Equatable {
  const CommentFormState();
  List<Object?> get props => [];
}

class InitialState extends CommentFormState {}

class LoadingCommentState extends CommentFormState {
  const LoadingCommentState();
}

class UserLoaded extends CommentFormState {
  final UserModel user;
  const UserLoaded(this.user);

  @override
  List<dynamic> get props => [user];
}

class LoadingCommentErrorState extends CommentFormState {
  final String error;
  const LoadingCommentErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
