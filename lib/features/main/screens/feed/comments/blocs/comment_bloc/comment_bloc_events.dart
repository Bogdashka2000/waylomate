part of 'comment_bloc.dart';

abstract class CommentFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserByCommentEvent extends CommentFormEvent {
  final int id;
  GetUserByCommentEvent(this.id);

  @override
  List<int> get props => [id];
}
