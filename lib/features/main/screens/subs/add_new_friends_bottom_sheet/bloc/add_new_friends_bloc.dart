import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';

part 'add_new_friends_bloc_events.dart';
part 'add_new_friends_bloc_states.dart';

class AddNewFriendsBloc
    extends Bloc<AddNewFriendsBlocEvents, AddNewFriendsBlocStates> {
  final UserRepository userRepository;
  AddNewFriendsBloc(this.userRepository) : super(InitialState()) {
    on<GetUnfollowedUsers>(_onGetUnfollowedUsers);
    on<ToggleToFollow>(_onToggleToFollow);
  }

  Future<void> _onGetUnfollowedUsers(
    GetUnfollowedUsers event,
    Emitter<AddNewFriendsBlocStates> emit,
  ) async {
    emit(const LoadingUnfollowedUsersState());

    try {
      final allUsers = await userRepository.getAllUsers();
      final me = await userRepository.getMe();
      final followed = event.followed;
      final unfollowed = allUsers
          .where((item) => !followed.any((exclude) => exclude.id == item.id))
          .toList();
      final result = unfollowed.where((item) => item.id != me.id).toList();

      emit(UnfollowedUsersLoaded(result));
    } catch (error) {
      emit(LoadingUnfollowedUserErrorsState(error.toString()));
    }
  }

  Future<void> _onToggleToFollow(
    ToggleToFollow event,
    Emitter<AddNewFriendsBlocStates> emit,
  ) async {
    emit(const LoadingUnfollowedUsersState());

    try {
      final result = await userRepository.followUser(event.userId);

      emit(UserFollowed());
    } catch (error) {
      emit(LoadingUnfollowedUserErrorsState(error.toString()));
    }
  }
}
