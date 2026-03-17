import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waylomate/features/authorization/data/models/hobby_model/model.dart';
import 'package:waylomate/features/authorization/data/models/goal_model/model.dart';
import 'package:waylomate/features/authorization/data/models/language_model/model.dart';
import 'package:waylomate/features/authorization/data/repositories/hobby_repository.dart';

part 'events.dart';
part 'states.dart';

class ProfileComponentsBloc extends Bloc<Event, State> {
  final AuthContentRepository authContentRepository;
  ProfileComponentsBloc(this.authContentRepository) : super(InitialState()) {
    on<HobbiesRequested>(_hobbyRequest);
    on<GoalsRequested>(_goalRequest);
    on<LanguagesRequested>(_languageRequest);
  }

  Future<void> _hobbyRequest(
    HobbiesRequested event,
    Emitter<State> emit,
  ) async {
    emit(const LoadingState());

    try {
      final hobbies = await authContentRepository.getHobbies();
      emit(HobbiesLoadedState(hobbies));
    } catch (error) {
      emit(ErrorState("Не удалось загрузить хобби из сервера $error"));
    }
  }

  Future<void> _goalRequest(GoalsRequested event, Emitter<State> emit) async {
    emit(const LoadingState());

    try {
      final goals = await authContentRepository.getGoals();
      emit(GoalsLoadedState(goals));
    } catch (error) {
      emit(ErrorState("Не удалось загрузить цели из сервера $error"));
    }
  }

  Future<void> _languageRequest(
    LanguagesRequested event,
    Emitter<State> emit,
  ) async {
    emit(const LoadingState());

    try {
      final languages = await authContentRepository.getLanguages();
      emit(LanguagesLoadedState(languages));
    } catch (error) {
      emit(ErrorState("Не удалось загрузить языки из сервера $error"));
    }
  }
}
