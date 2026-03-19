part of 'bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  List<Object?> get props => [];
}

class InitialState extends ProfileState {}

class LoadingState extends ProfileState {
  const LoadingState();
}

class HobbiesLoadedState extends ProfileState {
  final List<Hobby> hobbies;
  const HobbiesLoadedState(this.hobbies);

  @override
  List<Object> get props => [hobbies];
}

class GoalsLoadedState extends ProfileState {
  final List<Goal> goals;
  const GoalsLoadedState(this.goals);

  @override
  List<Object?> get props => [goals];
}

class LanguagesLoadedState extends ProfileState {
  final List<Language> languages;
  const LanguagesLoadedState(this.languages);

  @override
  List<Object?> get props => [languages];
}

class ErrorState extends ProfileState {
  final String error;
  const ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
