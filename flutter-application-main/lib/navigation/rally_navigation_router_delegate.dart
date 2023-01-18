import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_state.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';
import 'package:gibz_mobileapp/pages/rally/rally_entry_page.dart';

import '../bloc/rally/rally_event.dart';

class RallyNavigationRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RallyBloc, RallyState>(
      builder: (context, state) {
        return Navigator(
          key: _navigatorKey,
          pages: [
            if (state.pages.isEmpty)
              const MaterialPage(child: RallyEntryPage()),
            if (state.pages.isNotEmpty) ...state.pages,
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }

            popRoute();

            context.read<RallyBloc>().add(PoppedPageEvent());
            return true;
          },
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}
