part of 'add_new_friends_bloc.dart';

abstract class AddNewFriendsBlocEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUnfollowedUsers extends AddNewFriendsBlocEvents {
  final List<UserModel> followed;
  GetUnfollowedUsers(this.followed);

  @override
  List<List<UserModel>> get props => [followed];
}

class ToggleToFollow extends AddNewFriendsBlocEvents {
  final int userId;
  ToggleToFollow(this.userId);

  @override
  List<int> get props => [userId];
}
