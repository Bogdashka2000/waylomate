import 'package:dio/dio.dart';
import 'package:waylomate/features/authorization/data/models/goal_model/model.dart';
import 'package:waylomate/features/authorization/data/models/hobby_model/model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waylomate/features/authorization/data/models/language_model/model.dart';
import 'package:waylomate/features/authorization/data/models/login_model/request_model.dart';
import 'package:waylomate/features/authorization/data/models/login_model/response_model.dart';
import 'package:waylomate/features/authorization/data/models/registration_model/request_model.dart';
import 'package:waylomate/features/authorization/data/models/registration_model/response_model.dart';

class AuthContentRepository {
  final dio = Dio();

  Future<String> loginUser(UserLoginRequest ulr) async {
    final server = dotenv.env['SERVER'];
    if (server == null || server.isEmpty) {
      throw Exception('Server в .env отсутствует');
    }
    final response = await dio.post(
      "http://$server/user/login",
      data: ulr.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 401) {
      throw Exception('Неверная почта или пароль');
    }
    if (response.statusCode == 422) {
      throw Exception('Ошибка валидации');
    }

    final dynamic data = response.data;
    return UserLoginResponse.fromJson(data).message;
  }

  Future<UserRegistrationResponse> sendUserData(
    UserRegistrationRequest urr,
  ) async {
    final server = dotenv.env['SERVER'];
    if (server == null || server.isEmpty) {
      throw Exception('Server в .env отсутствует');
    }
    final response = await dio.post(
      "http://$server/user/registration",
      data: urr.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 409) {
      throw Exception('Пользователь уже существует');
    }
    if (response.statusCode == 422) {
      throw Exception('Ошибка валидации');
    }

    final dynamic data = response.data;
    return UserRegistrationResponse.fromJson(data);
  }

  Future<List<T>> _getElementFromServer<T>(
    String element,
    T Function(Map<String, dynamic> json) fromJsonFactory,
  ) async {
    final server = dotenv.env['SERVER'];
    if (server == null || server.isEmpty) {
      throw Exception('Server в .env отсутствует');
    }
    final response = await dio.get("http://$server/$element");
    final List<dynamic> data = response.data;
    return data
        .map((json) => fromJsonFactory(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<Hobby>> getHobbies() async {
    return _getElementFromServer<Hobby>(
      'hobby',
      (json) => Hobby.fromJson(json),
    );
  }

  Future<List<Goal>> getGoals() async {
    return _getElementFromServer<Goal>('goal', (json) => Goal.fromJson(json));
  }

  Future<List<Language>> getLanguages() async {
    return _getElementFromServer<Language>(
      'language',
      (json) => Language.fromJson(json),
    );
  }
}
