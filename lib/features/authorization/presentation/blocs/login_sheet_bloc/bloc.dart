import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waylomate/core/network/models/hobby_model/model.dart';
import 'package:waylomate/core/network/models/goal_model/model.dart';
import 'package:waylomate/core/network/models/language_model/model.dart';
import 'package:waylomate/core/network/models/login_model/request_model.dart';
import 'package:waylomate/core/network/repositories/auth_content_repository.dart';

part 'events.dart';
part 'states.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthContentRepository authContentRepository;
  LoginFormBloc(this.authContentRepository) : super(InitialState()) {
    on<LoginSubmitted>(_onSendLogin);
  }

  Future<void> _onSendLogin(
    LoginSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    emit(const LoadingState());

    try {
      UserLoginRequest ulr = UserLoginRequest(
        email: event.email,
        password: event.password,
      );

      final result = await authContentRepository.loginUser(ulr);
      emit(LoginValidState(result));
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }
}
