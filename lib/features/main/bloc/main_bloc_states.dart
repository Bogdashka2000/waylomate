part of 'main_bloc.dart';

abstract class MainFormState extends Equatable {
  const MainFormState();
  List<Object?> get props => [];
}

class InitialState extends MainFormState {}

class LoadingMainState extends MainFormState {
  const LoadingMainState();
}

class MeLoaded extends MainFormState {
  final UserModel user;
  const MeLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class LoadingMainErrorState extends MainFormState {
  final String error;
  const LoadingMainErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
