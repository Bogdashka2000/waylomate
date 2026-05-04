import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';

part 'subs_bloc_events.dart';
part 'subs_bloc_states.dart';

class SubsFormBloc extends Bloc<SubsFormEvent, SubsFormState> {
  final UserRepository userRepository;
  SubsFormBloc(this.userRepository) : super(InitialState()) {
    on<GetFollowersAndFollows>(_onGetFollowersAndFollowed);
    on<ToggleToUnfollow>(_onToggleToUnfollow);
  }

  Future<void> _onGetFollowersAndFollowed(
    GetFollowersAndFollows event,
    Emitter<SubsFormState> emit,
  ) async {
    emit(const LoadingSubsState());

    try {
      final followers = await userRepository.getFollowersById(event.userId);
      final followed = await userRepository.getFollowsById(event.userId);
      emit(FollowersAndFollowsLoaded(followers, followed));
    } catch (error) {
      emit(LoadingSubsErrorState(error.toString()));
    }
  }

  Future<void> _onToggleToUnfollow(
    ToggleToUnfollow event,
    Emitter<SubsFormState> emit,
  ) async {
    emit(const LoadingSubsState());

    try {
      await userRepository.followUser(event.userId);
      emit(LoadingSubsState());
    } catch (error) {
      emit(LoadingSubsErrorState(error.toString()));
    }
  }
}
