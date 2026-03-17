part of 'bloc.dart';

sealed class State extends Equatable {
  const State();
  List<Object?> get props => [];
}

class InitialState extends State {}

class LoadingState extends State {
  const LoadingState();
}

class HobbiesLoadedState extends State {
  final List<Hobby> hobbies;
  const HobbiesLoadedState(this.hobbies);

  @override
  List<Object?> get props => [hobbies];
}

class GoalsLoadedState extends State {
  final List<Goal> goals;
  const GoalsLoadedState(this.goals);

  @override
  List<Object?> get props => [goals];
}

class LanguagesLoadedState extends State {
  final List<Language> languages;
  const LanguagesLoadedState(this.languages);

  @override
  List<Object?> get props => [languages];
}

class ErrorState extends State {
  final String error;
  const ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
