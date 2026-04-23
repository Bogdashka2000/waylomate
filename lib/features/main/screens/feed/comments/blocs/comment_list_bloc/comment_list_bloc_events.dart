part of 'comment_list_bloc.dart';

abstract class CommentListFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCommentsEvent extends CommentListFormEvent {
  final int postId;
  GetCommentsEvent(this.postId);

  @override
  List<int> get props => [postId];
}

class SendCommentEvent extends CommentListFormEvent {
  final int postId;
  final String text;
  SendCommentEvent(this.postId, this.text);

  @override
  List<dynamic> get props => [postId, text];
}
