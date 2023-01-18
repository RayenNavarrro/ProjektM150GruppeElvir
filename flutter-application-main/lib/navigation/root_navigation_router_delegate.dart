import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/root_navigation_cubit.dart';
import 'package:gibz_mobileapp/bloc/tab_bar_navigation_cubit.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';
import 'package:gibz_mobileapp/navigation/tab_bar_navigation_delegate.dart';

class RootNavigationRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final RootNavigationCubit _cubit;

  RootNavigationRouterDelegate(this._cubit);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootNavigationCubit, int>(
      builder: (context, stack) => Navigator(
        key: navigatorKey,
        pages: const [
          MaterialPage(
            child: RootPage(),
          ),
        ],
        onPopPage: (route, result) {
          // if (!route.didPop(result)) {
          //   return false;
          // }

          // popRoute();
          // return true;

          return route.didPop(result);
        },
      ),
      listener: (context, stack) {},
    );
  }

  // @override
  // Future<bool> popRoute() {
  //   // TODO: implement popRoute
  //   return Future.value(true);
  //   return super.popRoute();
  // }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    if (configuration.path == '/') {
      _cubit.activateView(0);
      return SynchronousFuture(null);
    }

    throw UnimplementedError("No routing on root level implemented yet.");
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        backButtonDispatcher: Router.of(context)
            .backButtonDispatcher!
            .createChildBackButtonDispatcher(),
        routerDelegate: TabBarNavigationRouterDelegate(
            context.read<TabBarNavigationCubit>()),
      ),
      // bottomNavigationBar: AnimatedNavigationBar(
      //   backgroundColor: const Color.fromRGBO(0, 98, 160, 1),
      //   showElevation: true,
      //   itemCornerRadius: 24,
      //   curve: Curves.linear,
      //   items: const [
      //     NavigationBarItem(
      //       icon: Icon(Icons.chrome_reader_mode),
      //       title: Text('Handbuch'),
      //       rootPathSegment: "knowledgebase",
      //     ),
      //     NavigationBarItem(
      //       icon: Icon(Icons.restaurant_menu),
      //       title: Text('Menüplan'),
      //       rootPathSegment: "menu",
      //     ),
      //     NavigationBarItem(
      //       icon: Icon(Icons.local_parking),
      //       title: Text('Parkplätze'),
      //       rootPathSegment: "parking",
      //     ),
      //     NavigationBarItem(
      //       icon: Icon(Icons.route),
      //       title: Text('Rallye'),
      //       rootPathSegment: 'rally',
      //     ),
      //   ],
      //   onItemSelected: (rootPathSegment) {
      //     PageConfiguration pageConfiguration =
      //         DefaultPageConfiguration(path: rootPathSegment);
      //     context.read<TabBarNavigationCubit>().activateTab(pageConfiguration);
      //   },
      // ),
    );
  }
}
