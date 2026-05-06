import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/models/news_model/news_model.dart';

class NewsRepository {
  final DioClient dio;

  NewsRepository(this.dio);

  Future<List<NewsModel>> getNews() async {
    try {
      final response = await dio.dio.get("/news");
      final List<dynamic> jsonList = response.data as List;
      return jsonList
          .map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
