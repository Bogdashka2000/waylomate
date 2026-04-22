part of 'post_bloc.dart';

abstract class PostFormState extends Equatable {
  const PostFormState();
  List<Object?> get props => [];
}

class InitialState extends PostFormState {}

class LoadingPostState extends PostFormState {
  const LoadingPostState();
}

class UserLoaded extends PostFormState {
  final UserModel user;
  final bool? isLiked;
  final int? totalLikes;
  const UserLoaded(this.user, this.isLiked, this.totalLikes);

  @override
  List<dynamic> get props => [user, isLiked, totalLikes];
}

class IsLikeToggeled extends PostFormState {
  final LikeModel like;
  const IsLikeToggeled(this.like);

  @override
  List<Object> get props => [like];
}

class LoadingPostErrorState extends PostFormState {
  final String error;
  const LoadingPostErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
