part of 'post_bloc.dart';

abstract class PostFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserByPostEvent extends PostFormEvent {
  final int id;
  GetUserByPostEvent(this.id);

  @override
  List<int> get props => [id];
}

class LikeToggleEvent extends PostFormEvent {
  final int postId;
  LikeToggleEvent(this.postId);

  @override
  List<int> get props => [postId];
}
