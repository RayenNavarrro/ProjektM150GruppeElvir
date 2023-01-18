import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/data/repositories/students_manual/article_repository.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

import '../navigation/navigation_stack.dart';

class KnowledgebaseNavigationCubit extends Cubit<NavigationStack> {
  final ArticleRepository articleRepository;

  KnowledgebaseNavigationCubit({
    required NavigationStack initialStack,
    required this.articleRepository,
  }) : super(initialStack);

  void push(PageConfiguration pageConfiguration) {
    emit(state.push(pageConfiguration));
  }

  bool canPop() {
    return state.pages.length > 1;
  }

  void pop() {
    emit(state.pop());
  }
}
