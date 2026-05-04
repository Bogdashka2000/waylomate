part of 'subs_bloc.dart';

abstract class SubsFormState extends Equatable {
  const SubsFormState();
  List<Object?> get props => [];
}

class InitialState extends SubsFormState {}

class LoadingSubsState extends SubsFormState {
  const LoadingSubsState();
}

class FollowersAndFollowsLoaded extends SubsFormState {
  final List<UserModel> followers;
  final List<UserModel> followed;
  const FollowersAndFollowsLoaded(this.followers, this.followed);

  @override
  List<Object> get props => [followers, followed];
}

class LoadingSubsErrorState extends SubsFormState {
  final String error;
  const LoadingSubsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
