import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waylomate/core/network/models/hobby_model/model.dart';
import 'package:waylomate/core/network/models/goal_model/model.dart';
import 'package:waylomate/core/network/models/language_model/model.dart';
import 'package:waylomate/core/network/repositories/auth_content_repository.dart';

part 'events.dart';
part 'states.dart';

class ProfileComponentsBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthContentRepository authContentRepository;
  ProfileComponentsBloc(this.authContentRepository) : super(InitialState()) {
    on<HobbiesRequested>(_hobbyRequest);
    on<GoalsRequested>(_goalRequest);
    on<LanguagesRequested>(_languageRequest);
  }

  Future<void> _hobbyRequest(
    HobbiesRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const LoadingState());

    try {
      final hobbies = await authContentRepository.getHobbies();
      emit(HobbiesLoadedState(hobbies));
    } catch (error) {
      emit(ErrorState("Не удалось загрузить хобби из сервера"));
    }
  }

  Future<void> _goalRequest(
    GoalsRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const LoadingState());

    try {
      final goals = await authContentRepository.getGoals();
      emit(GoalsLoadedState(goals));
    } catch (error) {
      emit(ErrorState("Не удалось загрузить цели из сервера"));
    }
  }

  Future<void> _languageRequest(
    LanguagesRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const LoadingState());

    try {
      final languages = await authContentRepository.getLanguages();
      emit(LanguagesLoadedState(languages));
    } catch (error) {
      emit(ErrorState("Не удалось загрузить языки из сервера"));
    }
  }
}
