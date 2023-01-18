import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/tab_bar_navigation_cubit.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 50,
          left: 16,
          right: 16,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 31, 138, 205),
              Color.fromARGB(255, 0, 62, 100),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/Logo_GIBZ_zweizeilig_weiss.png',
                  width: 200,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      // 'Mit der App des Gewerblich-industriellen Bildungszentrum Zug sind wesentliche Informationen rund um den Schulbetrieb am GIBZ schnell und einfach verfügbar - jederzeit aktuell.',
                      'Mit der App des GIBZ die wichtigsten Informationen in deiner Hosentasche.\nJederzeit aktuell.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            HomePageBox(
                              title: 'Handbuch für Lernende',
                              icon: Icons.chrome_reader_mode_outlined,
                              pageConfiguration:
                                  KnowledgeBasePageConfiguration(),
                            ),
                            HomePageBox(
                              title: 'Menüplan Restaurant Treff',
                              icon: Icons.restaurant_outlined,
                              pageConfiguration: MenuInfoPageConfiguration(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            HomePageBox(
                              title: 'Parkplatz-Informationen',
                              icon: Icons.local_parking_outlined,
                              pageConfiguration: ParkingInfoPageConfiguration(),
                            ),
                            HomePageBox(
                              title: 'GIBZ Rallye',
                              icon: Icons.route_outlined,
                              pageConfiguration: RallyHomePageConfiguration(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final PageConfiguration pageConfiguration;
  const HomePageBox({
    required this.title,
    required this.icon,
    required this.pageConfiguration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 120,
        decoration: BoxDecoration(
          color: const Color.fromARGB(80, 255, 255, 255),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context
                  .read<TabBarNavigationCubit>()
                  .navigateTo(pageConfiguration);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
