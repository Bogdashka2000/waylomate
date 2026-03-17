part of 'bloc.dart';

sealed class Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class HobbiesRequested extends Event {}

class GoalsRequested extends Event {}

class LanguagesRequested extends Event {}
