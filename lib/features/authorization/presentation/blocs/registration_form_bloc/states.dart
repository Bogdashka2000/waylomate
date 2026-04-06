part of 'bloc.dart';

abstract class RegistrationFormState extends Equatable {
  const RegistrationFormState();
  @override
  List<Object?> get props => [];
}

class RegistrationFormInitial extends RegistrationFormState {
  const RegistrationFormInitial();
}

class RegistrationFormInProgress extends RegistrationFormState {
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;
  final Gender gender;
  final List<int> selectedHobbyIds;
  final List<int> selectedGoalIds;
  final List<int> selectedLanguageIds;
  final String? about;
  final String? email;
  final String? password;
  final bool isSubmitting;
  final String? error;

  const RegistrationFormInProgress({
    this.firstName,
    this.lastName,
    this.birthday,
    this.gender = Gender.none,
    this.selectedHobbyIds = const [],
    this.selectedGoalIds = const [],
    this.selectedLanguageIds = const [],
    this.about,
    this.email,
    this.password,
    this.isSubmitting = false,
    this.error,
  });

  RegistrationFormInProgress copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthday,
    Gender? gender,
    List<int>? selectedHobbyIds,
    List<int>? selectedGoalIds,
    List<int>? selectedLanguageIds,
    String? about,
    String? email,
    String? password,
    bool? isSubmitting,
    String? error,
  }) {
    return RegistrationFormInProgress(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      selectedHobbyIds: selectedHobbyIds != null
          ? List<int>.from(selectedHobbyIds)
          : this.selectedHobbyIds,
      selectedGoalIds: selectedGoalIds != null
          ? List<int>.from(selectedGoalIds)
          : this.selectedGoalIds,
      selectedLanguageIds: selectedLanguageIds != null
          ? List<int>.from(selectedLanguageIds)
          : this.selectedLanguageIds,
      about: about ?? this.about,
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    birthday,
    gender,
    selectedHobbyIds,
    selectedGoalIds,
    selectedLanguageIds,
    about,
    email,
    password,
    isSubmitting,
    error,
  ];
}

class RegistrationFormSuccess extends RegistrationFormState {
  final UserRegistrationResponse urr;
  const RegistrationFormSuccess({required this.urr});
  @override
  List<Object?> get props => [urr];
}

class RegistrationFormFailure extends RegistrationFormState {
  final Object? error;
  const RegistrationFormFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
