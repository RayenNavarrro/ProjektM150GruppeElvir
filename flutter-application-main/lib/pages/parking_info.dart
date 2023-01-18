import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/data/repositories/parking_information.dart/car_park_repository.dart';
import 'package:gibz_mobileapp/models/parking_information/parking_information.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/widgets/gibz_progress_indicator.dart';
import 'package:gibz_mobileapp/widgets/radial_gauge.dart';

class ParkingInfoPage extends StatelessWidget {
  const ParkingInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: 'Parking am GIBZ',
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: FutureBuilder<CarPark>(
            future: context.read<ParkingRepository>().getCurrentAvailability(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const GibzProgressIndicator(
                  indicatorText: 'Aktuelle Parkplatzdaten werden geladen...',
                );
              }
              return Column(
                children: [
                  RadialGauge(
                    maxValue: 82,
                    currentValue: snapshot.data?.currentAvailability.free ?? 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.0),
                          child: Text(
                            'Öffnungszeiten',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ...?snapshot.data?.openingHours.map(
                          (openingHour) => Text(
                            openingHour,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 7.0,
                          ),
                          child: Text(
                            'Bezahlmöglichkeiten',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (snapshot.data != null)
                          Text(
                            snapshot.data!.paymentOptions.join(", "),
                            style: const TextStyle(fontSize: 14),
                          )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
