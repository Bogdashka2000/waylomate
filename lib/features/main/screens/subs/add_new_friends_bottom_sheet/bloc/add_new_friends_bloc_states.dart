part of 'add_new_friends_bloc.dart';

abstract class AddNewFriendsBlocStates extends Equatable {
  const AddNewFriendsBlocStates();
  List<Object?> get props => [];
}

class InitialState extends AddNewFriendsBlocStates {}

class UserFollowed extends AddNewFriendsBlocStates {}

class LoadingUnfollowedUsersState extends AddNewFriendsBlocStates {
  const LoadingUnfollowedUsersState();
}

class UnfollowedUsersLoaded extends AddNewFriendsBlocStates {
  final List<UserModel> unfollowed;
  const UnfollowedUsersLoaded(this.unfollowed);

  @override
  List<Object> get props => [unfollowed];
}

class LoadingUnfollowedUserErrorsState extends AddNewFriendsBlocStates {
  final String error;
  const LoadingUnfollowedUserErrorsState(this.error);

  @override
  List<Object?> get props => [error];
}
