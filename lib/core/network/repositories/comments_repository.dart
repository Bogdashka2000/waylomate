import 'package:dio/dio.dart';
import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/models/comment_model/model.dart';
import 'package:waylomate/core/network/models/like_model/model.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';

class CommentRepository {
  final DioClient dio;

  CommentRepository(this.dio);

  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    try {
      final response = await dio.dio.get("/comment/by_post/$postId");
      final List<dynamic> jsonList = response.data as List;
      return jsonList
          .map((json) => CommentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> sendComment(int postId, String text) async {
    try {
      await dio.dio.post(
        "/comment/add",
        data: {"post_id": postId, "text": text},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
