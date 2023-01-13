import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';

class Imprint extends StatelessWidget {
  const Imprint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: 'Impressum',
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Die GIBZ App ist für iOS und Android in den jeweiligen Stores gratis zum Download verfügbar.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                      'Die Inhalte und Informationen stammen aus verschiedenen, öffentlich zugänglichen Quellen. Das GIBZ als Betreiberin haftet nicht für Aktualität und Korrektheit der Daten.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Betrieb',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Text(
                    'Gewerblich-industrielles Bildungszentrum Zug\nBaarerstrasse 100\nPostfach\n6301 Zug\nhttps://www.gibz.ch\n041 728 30 30'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Idee, Konzept, Realisierung',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Text('Peter Gisler'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Backend',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Text(
                    'Das Backend zur Speicherung, Aufbereitung und Auslieferung verschiedener Daten wird unter der Leitung von Peter Gisler mit ausgewählten Lernenden und Klassen des GIBZ im Rahmen des regulären Berufsschulunterrichts für Informatik mit Fachrichtung Applikationsentwicklung entwickelt.'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Handbuch für Lernende',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const Text('Alina Meyer'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Menüplan ZFV',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const Text('Annika Christen und weitere Lernende'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Parkplatz-Info',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Text('André Schreiber und weitere Lernende'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
