part of 'main_bloc.dart';

abstract class MainFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMe extends MainFormEvent {
  GetMe();
}
