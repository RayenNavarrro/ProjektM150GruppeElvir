import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/knowledgebase_filter_cubit.dart';
import 'package:gibz_mobileapp/bloc/knowledgebase_navigation_cubit.dart';
import 'package:gibz_mobileapp/data/repositories/students_manual/article_repository.dart';
import 'package:gibz_mobileapp/models/students_manual/students_manual.dart';
import 'package:gibz_mobileapp/navigation/navigation_stack.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';
import 'package:gibz_mobileapp/widgets/gibz_progress_indicator.dart';
import 'package:gibz_mobileapp/widgets/knowledgebase_search_box.dart';

import '../pages/new_app_bar.dart';

class KnowledgebaseNavigationRouterDelegate
    extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final KnowledgebaseNavigationCubit _cubit;
  KnowledgebaseNavigationRouterDelegate(this._cubit);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KnowledgebaseNavigationCubit, NavigationStack>(
      builder: (context, stack) {
        return Navigator(
          key: _navigatorKey,
          pages: [
            MaterialPage(
              child: BlocProvider<KnowledgebaseFilterCubit>(
                create: (_) => KnowledgebaseFilterCubit([]),
                child: Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                          delegate: GibzAppBar(title: "Handbuch für Lernende"),
                          pinned: true),
                      SliverPersistentHeader(
                        delegate: KnowledgebaseSearchBox(),
                        pinned: false,
                        floating: true,
                      ),
                      FutureBuilder<List<Article>>(
                        future: context.read<ArticleRepository>().getArticles(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SliverToBoxAdapter(
                              child: GibzProgressIndicator(
                                  indicatorText:
                                      'Das Handbuch wird geladen...'),
                            );
                          }
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const SliverToBoxAdapter(
                                child: Text('Keine Einträge vorhanden'));
                          }

                          context
                              .read<KnowledgebaseFilterCubit>()
                              .setData(snapshot.data!);
                          return BlocBuilder<KnowledgebaseFilterCubit,
                              List<Article>>(
                            builder: ((context, state) {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final Article article = state[index];
                                    return ListTile(
                                      visualDensity: VisualDensity.compact,
                                      title: Text(article.title),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        context
                                            .read<
                                                KnowledgebaseNavigationCubit>()
                                            .push(
                                                KnowledgeBaseDetailPageConfiguration(
                                              id: article.id,
                                              title: article.title,
                                            ));
                                      },
                                    );
                                  },
                                  childCount: state.length,
                                ),
                              );
                            }),
                          );
                          // }
                        },
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 25))
                    ],
                  ),
                ),
              ),
            ),
            ...stack.pages,
          ],
          onPopPage: (route, result) {
            _cubit.pop();
            return route.didPop(result);
          },
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    // if (configuration.path != "/") _cubit.push(configuration);
    return SynchronousFuture(null);
  }
}
