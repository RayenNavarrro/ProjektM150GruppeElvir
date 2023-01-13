import 'package:gibz_mobileapp/data/apis/students_manual/article_api_data_provider.dart';
import 'package:gibz_mobileapp/data/dio.dart';

import '../../../models/students_manual/students_manual.dart';

class ArticleRepository {
  final ArticleApiDataProvider _apiDataProvider;

  ArticleRepository({ArticleApiDataProvider? apiDataProvider})
      : _apiDataProvider =
            apiDataProvider ?? ArticleApiDataProvider(DioClient());

  Future<List<Article>> getArticles() async {
    return _apiDataProvider.getArticles();
  }

  Future<Article> getArticle(String id) async {
    return _apiDataProvider.getArticle(id);
  }
}
