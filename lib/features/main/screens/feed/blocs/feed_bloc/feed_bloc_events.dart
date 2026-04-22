part of 'feed_bloc.dart';

abstract class FeedFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPostsEvent extends FeedFormEvent {
  GetPostsEvent();
}
