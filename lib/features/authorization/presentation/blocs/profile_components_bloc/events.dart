part of 'bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HobbiesRequested extends ProfileEvent {}

class GoalsRequested extends ProfileEvent {}

class LanguagesRequested extends ProfileEvent {}
