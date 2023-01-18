import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/models/students_manual/students_manual.dart';

class KnowledgebaseFilterCubit extends Cubit<List<Article>> {
  List<Article> _articles;

  KnowledgebaseFilterCubit(List<Article> articles)
      : _articles = articles,
        super(articles);

  void setData(List<Article> articles) {
    _articles = articles;
    emit(_articles);
  }

  void filter(String? filterValue) {
    if (filterValue == null) {
      emit(_articles);
    } else {
      final lowerCaseFilterValue = filterValue.toLowerCase();
      final filtered = _articles
          .where((article) =>
              article.title.toLowerCase().contains(lowerCaseFilterValue) ||
              article.content.toLowerCase().contains(lowerCaseFilterValue))
          .toList();
      emit(filtered);
    }
  }
}
