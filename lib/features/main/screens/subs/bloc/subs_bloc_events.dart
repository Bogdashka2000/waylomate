part of 'subs_bloc.dart';

abstract class SubsFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFollowersAndFollows extends SubsFormEvent {
  final int userId;
  GetFollowersAndFollows(this.userId);

  @override
  List<int> get props => [userId];
}

class ToggleToUnfollow extends SubsFormEvent {
  final int userId;
  ToggleToUnfollow(this.userId);
}
