part of 'bloc.dart';

enum Gender { woman, man, none }

abstract class RegistrationFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsernameChanged extends RegistrationFormEvent {
  final String firstName;
  final String lastName;
  UsernameChanged(this.firstName, this.lastName);

  @override
  List<String> get props => [firstName, lastName];
}

class BirthdayChanged extends RegistrationFormEvent {
  final DateTime birthday;
  BirthdayChanged(this.birthday);

  @override
  List<DateTime> get props => [birthday];
}

class GenderChanged extends RegistrationFormEvent {
  final Gender gender;
  GenderChanged(this.gender);

  @override
  List<Gender> get props => [gender];
}

class HobbySelected extends RegistrationFormEvent {
  final int hobbyId;
  HobbySelected(this.hobbyId);

  @override
  List<int> get props => [hobbyId];
}

class HobbyUnselected extends RegistrationFormEvent {
  final int hobbyId;
  HobbyUnselected(this.hobbyId);

  @override
  List<int> get props => [hobbyId];
}

class GoalSelected extends RegistrationFormEvent {
  final int goalId;
  GoalSelected(this.goalId);

  @override
  List<int> get props => [goalId];
}

class GoalUnselected extends RegistrationFormEvent {
  final int goalId;
  GoalUnselected(this.goalId);

  @override
  List<int> get props => [goalId];
}

class LanguageSelected extends RegistrationFormEvent {
  final int languageId;
  LanguageSelected(this.languageId);

  @override
  List<int> get props => [languageId];
}

class LanguageUnselected extends RegistrationFormEvent {
  final int languageId;
  LanguageUnselected(this.languageId);

  @override
  List<int> get props => [languageId];
}

class AboutChanged extends RegistrationFormEvent {
  final String about;
  AboutChanged(this.about);

  @override
  List<String> get props => [about];
}

class PasswordChanged extends RegistrationFormEvent {
  final String password;
  PasswordChanged(this.password);

  @override
  List<String> get props => [password];
}

class EmailChanged extends RegistrationFormEvent {
  final String email;
  EmailChanged(this.email);

  @override
  List<String> get props => [email];
}

class SendUserData extends RegistrationFormEvent {
  SendUserData();
}
