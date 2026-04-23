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
}
