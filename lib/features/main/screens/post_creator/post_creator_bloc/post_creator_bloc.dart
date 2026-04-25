import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';

part 'post_creator_bloc_events.dart';
part 'post_creator_bloc_states.dart';

class PostCreatorFormBloc
    extends Bloc<PostCreatorFormEvent, PostCreatorFormState> {
  final PostRepository postRepository;
  PostCreatorFormBloc(this.postRepository) : super(InitialState()) {
    on<SendPostEvent>(_onSendPost);
  }

  Future<void> _onSendPost(
    SendPostEvent event,
    Emitter<PostCreatorFormState> emit,
  ) async {
    emit(const LoadingPostCreatorState());

    try {
      final result = await postRepository.sendPost(event.text);
      emit(PostSended());
    } catch (error) {
      emit(LoadingPostCreatorErrorState(error.toString()));
    }
  }
}
