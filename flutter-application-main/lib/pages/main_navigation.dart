import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/tab_bar_navigation_cubit.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
        left: 16,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 43, 60, 143),
            Color.fromARGB(255, 5, 20, 91),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 240,
              child:
                  Image.asset('assets/images/Logo_GIBZ_zweizeilig_weiss.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 0,
              ),
              child: Column(
                children: const [
                  MainNavigationItem(
                    label: "Handbuch für Lernende",
                    icon: Icons.chrome_reader_mode_outlined,
                    pageConfiguration: KnowledgeBasePageConfiguration(),
                  ),
                  MainNavigationItem(
                    label: "Menüpläne",
                    icon: Icons.restaurant_menu_outlined,
                    pageConfiguration: MenuInfoPageConfiguration(),
                  ),
                  MainNavigationItem(
                    label: "Parkplatz-Information",
                    icon: Icons.local_parking_outlined,
                    pageConfiguration: ParkingInfoPageConfiguration(),
                  ),
                  MainNavigationItem(
                    label: "GIBZ Rallye",
                    icon: Icons.route_outlined,
                    pageConfiguration: RallyHomePageConfiguration(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: MainNavigationItem(
                label: "Impressum",
                icon: Icons.info_outline_rounded,
                pageConfiguration: DefaultPageConfiguration(path: '/imprint'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainNavigationItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final PageConfiguration pageConfiguration;

  const MainNavigationItem({
    required this.label,
    required this.icon,
    required this.pageConfiguration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TabBarNavigationCubit>().navigateTo(pageConfiguration);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        // child: ListTile(
        //   leading: Icon(
        //     icon,
        //     color: Colors.white,
        //     size: 18,
        //   ),
        //   title: Text(
        //     label,
        //     style: const TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.normal,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
