import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'events.dart';
part 'states.dart';

class RegistrationFormBloc
    extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  RegistrationFormBloc() : super(RegistrationFormInitial()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<GenderChanged>(_onGenderChanged);
    on<HobbySelected>(_onHobbySelected);
    on<HobbyUnselected>(_onHobbyUnselected);
    on<GoalSelected>(_onGoalSelected);
    on<GoalUnselected>(_onGoalUnselected);
    on<LanguageSelected>(_onLanguageSelected);
    on<LanguageUnselected>(_onLanguageUnselected);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailChanged>(_onEmailChanged);
  }

  void _onUsernameChanged(
    UsernameChanged event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      emit(
        (state as RegistrationFormInProgress).copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
          error: null,
        ),
      );
    } else {
      emit(const RegistrationFormInProgress());
    }
  }

  void _onBirthdayChanged(
    BirthdayChanged event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      emit(
        (state as RegistrationFormInProgress).copyWith(
          birthday: event.birthday,
          error: null,
        ),
      );
    } else {
      emit(const RegistrationFormInProgress());
    }
  }

  void _onGenderChanged(
    GenderChanged event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      emit(
        (state as RegistrationFormInProgress).copyWith(
          gender: event.gender,
          error: null,
        ),
      );
    }
  }

  void _onHobbySelected(
    HobbySelected event,
    Emitter<RegistrationFormState> emit,
  ) {
    final currentState = state as RegistrationFormInProgress;
    if (!currentState.selectedHobbyIds.contains(event.hobbyId)) {
      emit(
        currentState.copyWith(
          selectedHobbyIds: [...currentState.selectedHobbyIds, event.hobbyId],
          error: null,
        ),
      );
    }
  }

  void _onHobbyUnselected(
    HobbyUnselected event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      final currentState = state as RegistrationFormInProgress;
      emit(
        currentState.copyWith(
          selectedHobbyIds: currentState.selectedHobbyIds
              .where((id) => id != event.hobbyId)
              .toList(),
          error: null,
        ),
      );
    }
  }

  void _onGoalSelected(
    GoalSelected event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      final currentState = state as RegistrationFormInProgress;
      if (!currentState.selectedGoalIds.contains(event.goalId)) {
        emit(
          currentState.copyWith(
            selectedGoalIds: [...currentState.selectedGoalIds, event.goalId],
            error: null,
          ),
        );
      }
    }
  }

  void _onGoalUnselected(
    GoalUnselected event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      final currentState = state as RegistrationFormInProgress;
      emit(
        currentState.copyWith(
          selectedGoalIds: currentState.selectedGoalIds
              .where((id) => id != event.goalId)
              .toList(),
          error: null,
        ),
      );
    }
  }

  void _onLanguageSelected(
    LanguageSelected event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      final currentState = state as RegistrationFormInProgress;
      if (!currentState.selectedLanguageIds.contains(event.languageId)) {
        emit(
          currentState.copyWith(
            selectedLanguageIds: [
              ...currentState.selectedLanguageIds,
              event.languageId,
            ],
            error: null,
          ),
        );
      }
    }
  }

  void _onLanguageUnselected(
    LanguageUnselected event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      final currentState = state as RegistrationFormInProgress;
      emit(
        currentState.copyWith(
          selectedLanguageIds: currentState.selectedLanguageIds
              .where((id) => id != event.languageId)
              .toList(),
          error: null,
        ),
      );
    }
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      emit(
        (state as RegistrationFormInProgress).copyWith(
          password: event.password,
          error: null,
        ),
      );
    }
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      emit(
        (state as RegistrationFormInProgress).copyWith(
          email: event.email,
          error: null,
        ),
      );
    }
  }

  // Future<void> _onRegistrationSubmitted(
  //   RegistrationSubmitted event,
  //   Emitter<RegistrationFormState> emit,
  // ) async {
  //   if (state is! RegistrationFormInProgress) return;

  //   final currentState = state as RegistrationFormInProgress;

  //   // 🔹 ВАЛИДАЦИЯ - все данные уже в currentState!
  //   if (currentState.firstName == null || currentState.firstName!.isEmpty) {
  //     emit(const RegistrationFormFailure(error: 'Введите имя'));
  //     return;
  //   }

  //   if (currentState.birthday == null) {
  //     emit(const RegistrationFormFailure(error: 'Выберите дату рождения'));
  //     return;
  //   }

  //   if (currentState.email == null || currentState.email!.isEmpty) {
  //     emit(const RegistrationFormFailure(error: 'Введите email'));
  //     return;
  //   }

  //   if (currentState.password == null || currentState.password!.length < 6) {
  //     emit(const RegistrationFormFailure(error: 'Пароль должен быть не менее 6 символов'));
  //     return;
  //   }

  //   emit(currentState.copyWith(isSubmitting: true, error: null));

  //   try {
  //     // 🔥 ОТПРАВКА НА СЕРВЕР - все данные в state!
  //     final user = await registerUser(RegisterUserParams(
  //       firstName: currentState.firstName!,
  //       lastName: currentState.lastName,
  //       birthDate: currentState.birthday!,
  //       gender: currentState.gender,
  //       hobbyIds: currentState.selectedHobbyIds,
  //       goalIds: currentState.selectedGoalIds,
  //       languageIds: currentState.selectedLanguageIds,
  //       email: currentState.email!,
  //       password: currentState.password!,
  //     ));

  //     emit(RegistrationFormSuccess(userId: user.id));
  //   } catch (e) {
  //     emit(RegistrationFormFailure(error: e.toString()));
  //   }
  // }

  // void _onRegistrationReset(RegistrationReset event, Emitter<RegistrationFormState> emit) {
  //   emit(const RegistrationFormInitial());
  // }
}
