import 'package:dio/dio.dart';
import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';

class UserRepository {
  final DioClient dio;

  UserRepository(this.dio);

  Future<UserModel> getUserById(int userId) async {
    try {
      final response = await dio.dio.get("/user/$userId");
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getMe() async {
    try {
      final response = await dio.dio.get("/user/im");
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> getFollowersById(int userId) async {
    try {
      final response = await dio.dio.get("/subscription/followers/$userId");
      final List<dynamic> jsonList = response.data as List;
      return jsonList
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> getFollowsById(int userId) async {
    try {
      final response = await dio.dio.get("/subscription/followed/$userId");
      final List<dynamic> jsonList = response.data as List;
      return jsonList
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await dio.dio.get("/user");
      final List<dynamic> jsonList = response.data as List;
      return jsonList
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> followUser(int userId) async {
    try {
      final response = await dio.dio.post(
        "/subscription/toggle",
        data: {"user_id": userId},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
