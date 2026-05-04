import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';

part 'main_bloc_events.dart';
part 'main_bloc_states.dart';

class MainFormBloc extends Bloc<MainFormEvent, MainFormState> {
  final UserRepository userRepository;
  MainFormBloc(this.userRepository) : super(InitialState()) {
    on<GetMe>(_onGetMe);
  }

  Future<void> _onGetMe(GetMe event, Emitter<MainFormState> emit) async {
    emit(const LoadingMainState());

    try {
      final result = await userRepository.getMe();
      emit(MeLoaded(result));
    } catch (error) {
      emit(LoadingMainErrorState(error.toString()));
    }
  }
}
