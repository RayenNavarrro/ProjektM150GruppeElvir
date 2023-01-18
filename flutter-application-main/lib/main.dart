import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibz_mobileapp/bloc/knowledgebase_navigation_cubit.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/bloc/menu_info/menu_info_cubit.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_state.dart';
import 'package:gibz_mobileapp/bloc/root_navigation_cubit.dart';
import 'package:gibz_mobileapp/bloc/tab_bar_navigation_cubit.dart';
import 'package:gibz_mobileapp/data/apis/rally/participating_party_api.dart';
import 'package:gibz_mobileapp/data/apis/rally/rally_stage_api.dart';
import 'package:gibz_mobileapp/data/apis/rally/stage_activity_result_api.dart';
import 'package:gibz_mobileapp/data/dio.dart';
import 'package:gibz_mobileapp/data/repositories/meal_information/meal_repository.dart';
import 'package:gibz_mobileapp/data/repositories/parking_information.dart/car_park_repository.dart';
import 'package:gibz_mobileapp/data/repositories/students_manual/article_repository.dart';
import 'package:gibz_mobileapp/navigation/root_navigation_router_delegate.dart';
import 'package:gibz_mobileapp/navigation/route_information_parser.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/services/rally/beacon_service.dart';

import 'bloc/rally/rally_event.dart';
import 'navigation/navigation_stack.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => LoadingIndicatorCubit(),
    child: MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ArticleRepository>(
          create: (_) => ArticleRepository(),
        ),
        RepositoryProvider<MealRepository>(
          create: (_) => MealRepository(),
        ),
        RepositoryProvider<ParkingRepository>(
          create: (_) => ParkingRepository(),
        ),
        RepositoryProvider<ParticipatingPartyApi>(
          create: (context) => ParticipatingPartyApi(
            DioClient(),
            context.read<LoadingIndicatorCubit>(),
          ),
        ),
        RepositoryProvider<RallyStageApi>(
          create: (_) => RallyStageApi(DioClient()),
        ),
        RepositoryProvider<StageActivityResultApi>(
          create: (context) => StageActivityResultApi(
            DioClient(),
            context.read<LoadingIndicatorCubit>(),
          ),
        ),
        // Todo: Since BeaconService is not a repository - use actual dependency injection
        RepositoryProvider<BeaconService>(
          create: (_) => BeaconService(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RootNavigationCubit()),
          BlocProvider(create: (_) => TabBarNavigationCubit("home")),
          BlocProvider(
            create: (context) => KnowledgebaseNavigationCubit(
              initialStack: const NavigationStack([]),
              articleRepository: context.read<ArticleRepository>(),
            ),
          ),
          BlocProvider(create: (_) => MenuInfoCubit()),
          BlocProvider(
            create: (context) => RallyBloc(
              initialState: const UninitializedSetupState(NavigationStack([])),
              participatingPartyApi: context.read<ParticipatingPartyApi>(),
              stageActivityResultApi: context.read<StageActivityResultApi>(),
              rallyStageApi: context.read<RallyStageApi>(),
              beaconService: context.read<BeaconService>(),
            )..add(PermissionsCheckInitiatedEvent()),
          ),
        ],
        child: const GibzApp(),
      ),
    ),
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class GibzApp extends StatefulWidget {
  const GibzApp({Key? key}) : super(key: key);

  @override
  State<GibzApp> createState() => _GibzAppState();
}

class _GibzAppState extends State<GibzApp> {
  final _routeInformationParser = UriRouteInformationParser();
  late RootNavigationRouterDelegate _rootNavigationRouterDelegate;

  @override
  void initState() {
    super.initState();
    _rootNavigationRouterDelegate =
        RootNavigationRouterDelegate(context.read<RootNavigationCubit>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        backButtonDispatcher: CustomRootBackButtonDispatcher(
          context.read<TabBarNavigationCubit>(),
        ),
        routeInformationParser: _routeInformationParser,
        routerDelegate: _rootNavigationRouterDelegate,
        title: 'GIBZ App',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 0, 98, 160),
          primaryColorDark: const Color.fromARGB(255, 0, 98, 160),
          primaryColorLight: const Color.fromARGB(255, 31, 138, 205),
          // primaryColorDark: Colors.deepOrangeAccent,
          // primaryColorLight: Colors.amberAccent,
          focusColor: Colors.red,
          fontFamily: 'CorporateS',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey.shade300;
                  }
                  return const Color.fromARGB(255, 0, 98, 160);
                },
              ),
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (states) => const StadiumBorder(),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                return const StadiumBorder();
              }),
              side: MaterialStateProperty.resolveWith<BorderSide>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return BorderSide(color: Theme.of(context).disabledColor);
                }
                return BorderSide(
                  color: Theme.of(context).primaryColor,
                );
              }),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Color.fromARGB(61, 0, 0, 0);
                }
                return const Color.fromARGB(255, 0, 98, 160);
              }),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontFamily: "CorporateS",
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ));
  }
}

class CustomRootBackButtonDispatcher extends RootBackButtonDispatcher {
  final TabBarNavigationCubit _cubit;

  CustomRootBackButtonDispatcher(this._cubit);

  @override
  Future<bool> didPopRoute() async {
    final fromSuper = await super.didPopRoute();
    if (!fromSuper) {
      _cubit.toggleMainMenu();
    }
    return Future.value(true);
    return super.didPopRoute();
  }
}
