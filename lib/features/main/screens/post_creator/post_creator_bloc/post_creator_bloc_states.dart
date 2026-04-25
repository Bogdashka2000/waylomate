part of 'post_creator_bloc.dart';

abstract class PostCreatorFormState extends Equatable {
  const PostCreatorFormState();
  List<Object?> get props => [];
}

class InitialState extends PostCreatorFormState {}

class LoadingPostCreatorState extends PostCreatorFormState {
  const LoadingPostCreatorState();
}

class PostSended extends PostCreatorFormState {
  const PostSended();
}

class LoadingPostCreatorErrorState extends PostCreatorFormState {
  final String error;
  const LoadingPostCreatorErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
