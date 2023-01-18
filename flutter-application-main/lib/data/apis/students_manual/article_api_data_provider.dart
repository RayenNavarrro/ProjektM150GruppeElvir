import 'package:gibz_mobileapp/data/dio.dart';
import 'package:gibz_mobileapp/models/students_manual/students_manual.dart';

class ArticleApiDataProvider {
  final DioClient _httpClient;

  ArticleApiDataProvider(this._httpClient);

  Future<List<Article>> getArticles() async {
    final response = await _httpClient.get('/api/studentsmanual/v1/article');
    return Mapper.fromJson<List<Article>>(response.data);
  }

  Future<Article> getArticle(String id) async {
    final response =
        await _httpClient.get('/api/studentsmanual/v1/article/$id');
    return Mapper.fromJson<Article>(response.data);
  }
}
