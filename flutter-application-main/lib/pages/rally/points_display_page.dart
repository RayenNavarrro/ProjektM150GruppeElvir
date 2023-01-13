import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/widgets/loading_indicator_button.dart';

class PointsDisplayPage extends StatelessWidget {
  final int latestPoints;
  final int totalPoints;

  const PointsDisplayPage({
    required this.latestPoints,
    required this.totalPoints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: "Aktueller Punktestand",
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                latestPoints.toString(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 98, 160),
                  fontSize: 60.0,
                  fontFamily: 'Saira Condensed',
                ),
              ),
              const Text(
                "Punkte",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 98, 160),
                  fontSize: 18,
                ),
              ),
              const Text("für die letzte Challenge"),
              const SizedBox(
                height: 30,
              ),
              Text(
                totalPoints.toString(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 98, 160),
                  fontSize: 40.0,
                  fontFamily: 'Saira Condensed',
                ),
              ),
              const Text(
                "Punkte",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 98, 160),
                  fontSize: 18,
                ),
              ),
              const Text("insgesamt"),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
                child: OutlinedLoadingIndicatorButton(
                  child: const Text('weiter'),
                  loadingAspect: LoadingAspect.none,
                  onPressed: () {
                    context.read<RallyBloc>().add(NextStageRequestedEvent());
                  },
                ),
                // child: TextButton(
                //   onPressed: () {
                //     context.read<RallyBloc>().add(NextStageRequestedEvent());
                //   },
                //   child: const Text("weiter"),
                // ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
