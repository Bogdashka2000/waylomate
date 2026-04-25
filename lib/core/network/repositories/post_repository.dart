import 'package:dio/dio.dart';
import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/models/like_model/model.dart';
import 'package:waylomate/core/network/models/post_model/model.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';

class PostRepository {
  final DioClient dio;

  PostRepository(this.dio);

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dio.dio.get("/post");
      final List<dynamic> jsonList = response.data as List;
      return jsonList
          .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserFromPost(int userId) async {
    try {
      final response = await dio.dio.get("/user/$userId");
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LikeModel> likeToggle(int postId) async {
    try {
      final response = await dio.dio.post(
        "/like/toggle",
        data: {"post_id": postId},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return LikeModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> sendPost(String text) async {
    try {
      await dio.dio.post(
        "/post/add",
        data: {"text": text},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
