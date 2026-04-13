part of 'bloc.dart';

abstract class LoginFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginFormEvent {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});
}
