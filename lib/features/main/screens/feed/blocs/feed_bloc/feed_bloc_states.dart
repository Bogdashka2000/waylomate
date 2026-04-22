part of 'feed_bloc.dart';

abstract class FeedFormState extends Equatable {
  const FeedFormState();
  List<Object?> get props => [];
}

class InitialState extends FeedFormState {}

class LoadingFeedState extends FeedFormState {
  const LoadingFeedState();
}

class PostLoaded extends FeedFormState {
  final List<PostModel> posts;
  const PostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class LoadingFeedErrorState extends FeedFormState {
  final String error;
  const LoadingFeedErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
