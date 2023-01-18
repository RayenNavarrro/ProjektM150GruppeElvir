import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/knowledgebase_navigation_cubit.dart';
import 'package:gibz_mobileapp/bloc/tab_bar_navigation_cubit.dart';
import 'package:gibz_mobileapp/navigation/knowledgebase_navigation_router_delegate.dart';
import 'package:gibz_mobileapp/navigation/rally_navigation_router_delegate.dart';
import 'package:gibz_mobileapp/pages/home.dart';
import 'package:gibz_mobileapp/pages/imprint.dart';
import 'package:gibz_mobileapp/pages/main_navigation.dart';
import 'package:gibz_mobileapp/pages/new_app_bar.dart';
import 'package:gibz_mobileapp/pages/parking_info.dart';
import 'package:gibz_mobileapp/widgets/menu_day_page_view.dart';
import 'package:gibz_mobileapp/widgets/menu_day_selector.dart';

import 'page_configuration.dart';

class MainNavigationDrawer extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  const MainNavigationDrawer(this._navigatorKey, {Key? key}) : super(key: key);

  @override
  State<MainNavigationDrawer> createState() => _MainNavigationDrawerState();
}

class _MainNavigationDrawerState extends State<MainNavigationDrawer>
    with SingleTickerProviderStateMixin {
  final double _maxSlide = 260.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 175),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabBarNavigationCubit, String>(
      listener: (context, state) {
        if (state == TabBarNavigationCubit.mainMenuState) {
          _showMainMenu();
        } else {
          _closeMainMenu();
        }
      },
      builder: (context, state) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          final slide = _maxSlide * _animationController.value;
          final scale = 1 - (_animationController.value * 0.3);
          return Stack(
            children: [
              const MainNavigation(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: BlocBuilder<TabBarNavigationCubit, String>(
                  builder: (context, state) => IgnorePointer(
                    ignoring: state == TabBarNavigationCubit.mainMenuState,
                    child: Scaffold(
                      body: BlocBuilder<TabBarNavigationCubit, String>(
                        buildWhen: (previous, current) =>
                            current != TabBarNavigationCubit.mainMenuState,
                        builder: (context, state) => Navigator(
                          key: widget._navigatorKey,
                          pages: [
                            if (state == "home")
                              const MaterialPage(child: HomePage()),
                            if (state == "imprint")
                              const MaterialPage(child: Imprint()),
                            if (state == "knowledgebase")
                              const MaterialPage(
                                child: KnowledgebaseRouter(),
                              ),
                            if (state == "menu")
                              MaterialPage(
                                  child: Scaffold(
                                body: NestedScrollView(
                                  headerSliverBuilder:
                                      (context, innerBoxIsScrolled) => [
                                    SliverOverlapAbsorber(
                                      handle: NestedScrollView
                                          .sliverOverlapAbsorberHandleFor(
                                              context),
                                      sliver: SliverPersistentHeader(
                                        delegate: GibzAppBar(
                                          title: "Menüplan",
                                          additionalChildren: [
                                            const Positioned(
                                              top: 48,
                                              left: 0,
                                              right: 0,
                                              child: MenuDaySelector(),
                                            ),
                                          ],
                                        ),
                                        pinned: true,
                                        floating: true,
                                      ),
                                    )
                                  ],
                                  floatHeaderSlivers: false,
                                  body: const Padding(
                                    padding: EdgeInsets.only(top: 80),
                                    child: MenuDayPageView(),
                                  ),
                                ),
                              )),
                            if (state == "parking")
                              const MaterialPage(child: ParkingInfoPage()),
                            if (state == "rally")
                              const MaterialPage(
                                child: RallyRouter(),
                              ),
                          ],
                          onPopPage: (route, result) {
                            return route.didPop(result);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showMainMenu() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  void _closeMainMenu() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }
}

class RallyRouter extends StatefulWidget {
  const RallyRouter({
    Key? key,
  }) : super(key: key);

  @override
  State<RallyRouter> createState() => _RallyRouterState();
}

class _RallyRouterState extends State<RallyRouter> {
  late ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        ?.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher?.takePriority();
    return Router(
      backButtonDispatcher: _backButtonDispatcher,
      routerDelegate: RallyNavigationRouterDelegate(),
    );
  }
}

class KnowledgebaseRouter extends StatefulWidget {
  const KnowledgebaseRouter({
    Key? key,
  }) : super(key: key);

  @override
  State<KnowledgebaseRouter> createState() => _KnowledgebaseRouterState();
}

class _KnowledgebaseRouterState extends State<KnowledgebaseRouter> {
  late ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        ?.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher?.takePriority();
    return Router(
      backButtonDispatcher: _backButtonDispatcher,
      routerDelegate: KnowledgebaseNavigationRouterDelegate(
          context.read<KnowledgebaseNavigationCubit>()),
    );
  }
}

class TabBarNavigationRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final TabBarNavigationCubit _cubit;

  TabBarNavigationRouterDelegate(this._cubit);

  @override
  Widget build(BuildContext context) {
    return MainNavigationDrawer(_navigatorKey);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    if (configuration.path != '/') _cubit.navigateTo(configuration);
    return SynchronousFuture(null);
  }
}
