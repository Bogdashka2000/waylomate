import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waylomate/features/authorization/data/models/registration_model/request_model.dart';
import 'package:waylomate/features/authorization/data/models/registration_model/response_model.dart';
import 'package:waylomate/features/authorization/data/repositories/auth_content_repository.dart';

part 'events.dart';
part 'states.dart';

class RegistrationFormBloc
    extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  final AuthContentRepository authContentRepository;
  RegistrationFormBloc(this.authContentRepository)
    : super(RegistrationFormInitial()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<GenderChanged>(_onGenderChanged);
    on<HobbySelected>(_onHobbySelected);
    on<HobbyUnselected>(_onHobbyUnselected);
    on<GoalSelected>(_onGoalSelected);
    on<GoalUnselected>(_onGoalUnselected);
    on<LanguageSelected>(_onLanguageSelected);
    on<LanguageUnselected>(_onLanguageUnselected);
    on<AboutChanged>(_onAboutChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailChanged>(_onEmailChanged);
    on<SendUserData>(_onSendUserData);
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

  void _onAboutChanged(
    AboutChanged event,
    Emitter<RegistrationFormState> emit,
  ) {
    if (state is RegistrationFormInProgress) {
      emit(
        (state as RegistrationFormInProgress).copyWith(
          password: event.about,
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

  Future<void> _onSendUserData(
    SendUserData event,
    Emitter<RegistrationFormState> emit,
  ) async {
    if (state is! RegistrationFormInProgress) return;
    try {
      final currentState = state as RegistrationFormInProgress;

      UserRegistrationRequest urr = UserRegistrationRequest(
        firstName: currentState.firstName!,
        lastName: currentState.lastName!,
        birthday: currentState.birthday!,
        gender: currentState.gender == Gender.man ? 'male' : 'female',
        hobbies: currentState.selectedHobbyIds,
        goals: currentState.selectedGoalIds,
        languages: currentState.selectedLanguageIds,
        email: currentState.email!,
        password: currentState.password!,
        about: currentState.about!,
      );

      UserRegistrationResponse user = await authContentRepository.sendUserData(
        urr,
      );

      emit(RegistrationFormSuccess(urr: user));
    } catch (e) {
      emit(RegistrationFormFailure(error: e));
    }
  }
}
