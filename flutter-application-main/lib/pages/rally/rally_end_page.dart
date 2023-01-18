import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:lottie/lottie.dart';

class RallyEndPage extends StatelessWidget {
  const RallyEndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: "Rallye beendet",
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Text(
                  "Herzliche Gratulation, Sie haben die Rallye erfolgreich beendet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Lottie.asset(
                      'assets/animations/lottie/rally_finish.json'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<RallyBloc>().add(RestartRequestedEvent());
                  },
                  child: const Text("Neue Rally starten"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
