part of 'post_creator_bloc.dart';

abstract class PostCreatorFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendPostEvent extends PostCreatorFormEvent {
  final String text;
  SendPostEvent(this.text);

  @override
  List<String> get props => [text];
}
