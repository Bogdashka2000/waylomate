part of 'bloc.dart';

abstract class LoginFormState extends Equatable {
  const LoginFormState();
  List<Object?> get props => [];
}

class InitialState extends LoginFormState {}

class LoadingState extends LoginFormState {
  const LoadingState();
}

class LoginValidState extends LoginFormState {
  final String message;
  const LoginValidState(this.message);

  @override
  List<Object> get props => [message];
}

class LoginErrorState extends LoginFormState {
  final String error;
  const LoginErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
