import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:gibz_mobileapp/pages/page_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

const staticMD = """
# This is markdown

Let's see whether we can **actually** really *use* this kind of markdown. We might want do print some text __bold__ or _italic_. It does work!

Let's check some emojis: 😘 🥁 🦠

- Enummerations
- are
- quite
- nice

And now an enumerated list:

1. Let's
2. see
3. whether
    1. this works
    2. really fine?
4. I even
5. used
    - mixed
    - lists
6. Without any problem at all!

What about a link to the [website](https://www.gibz.ch) https://www.zg.ch?

Here's an image for you all:

![Not working with https://www.gibz.ch in it?](https://www.zg.ch/behoerden/volkswirtschaftsdirektion/gibz/bilderkarussell-gibz/willkommen-in-unserem-modernen-bildungszentrum/@@images/0b13ef12-b87e-4733-8bca-2550d0521681.png)


## Tables anyone?

| Header 1 | Header 2 | Some quite long title here... |
| :------: | :------- | ----------------------------: |
| 1 | 2 | 3 |
| 1 | 2 | 3 |
| 1 | 2 | 3 |
| 1 | 2 | 3 |

## What about checkboxes?

- [ ] Still to do
- [x] Done already :-)
- [ ] An open one

And here are some checkmarks: :white_check_mark:


""";

const staticInfo = """
# Was ist der aktuelle Stand dieser App?

Diese App fungiert als Prototyp einer möglicherweise zu entwickelnden App für das GIBZ. Mit den Kacheln auf der Startseite werden einige mögliche Inhalte und Funktionen der App exemplarisch illustriert.

## Informationen für Lernende

Das *Handbuch für Lernende* ist aktuell als PDF verfügbar und wird von den Lernenden kaum genutzt. Eigentlich wäre damit jedoch ein wichtiges und mächtiges Werkzeug vorhanden. Die geringe Nutzung ist mitunter auf die schlechte Verfügbarkeit (statisches PDF, irgendwo "versteckt" auf der Webseite des GIBZ) und das geringe Mass an Relevanz für die Zielgruppe zurück zu führen. **Als App für das Smartphone mit interaktiven Inhalten, welche durchsucht, gefiltert, geteilt und bewertet werden können, können die bestehenden Inhalte für die Lernenden und Studierenden des GIBZ attraktiver vermittelt werden.**

## Menüplan

Für den Menüplan des Restaurant *Treff* existiert eine öffentlich verfügbare API zur Abfrage der aktuellen Angebote für die jeweils aktuelle Woche. Dieses nette Zusatzfeature für die App kann dazu verleiten, die App überhaupt zu installieren und ggf. häufiger bzw. regelmässig zu nutzen.

## Parkplätze

Auch die Anzahl verfügbarer Parkplätze im Parkhaus des GIBZ kann über eine öffentliche API abgefragt und innerhalb der App dargestellt werden. Der Nutzen ist begrenzt auf autofahrende Nutzerinnen und Nutzer, kann jedoch analog zum Menüplan zu einer regelmässigen Nutzung der App beitragen.

## Informationen

Hier wäre denkbar, verschiedene aktuelle Inhalte und Hinweise zu platzieren:

- Kurse und Veranstaltungen
- Wichtige Termine
- News aus verschiedenen Berufen
- Organisatorische und Administrative News
  - Materialrechnungen werden verteilt --> Erinnerung an Bezahlung
  - Aktualisiertes Covid-Schutzkonzept ist verfügbar
  - Neue Mitarbeitende im Support
  - etc.

In einem weiteren Ausbauschritt wäre auch die (selektive) Benachrichtigung mittels *Push Notifications* denkbar.

# Wofür könnte diese App sonst noch genutzt werden?

Die Erweiterungs- und Ausbaumöglichkeiten für eine GIBZ App sind vielseitig und beinahe unbegrenzt. Denkbare Beispiele mit kurz- bis mittelfristiger Umsetzung sind in den nachfolgenden Abschnitten ausgeführt.

## Erkundung des GIBZ

Bereits vor rund einem Jahr wurde eine funktionsfähige App entwickelt, mit welcher (neue) Lernende am GIBZ das Gebäude, die Berufe, die Angebote und den Betrieb der "neuen Schule" auf spielerische Art erkunden sollen. Die App wurde bereits für den obligatorischen *Review* an Apple übermittelt. Dort wurde die Publikation der App im App Store jedoch abgelehnt, weil eine solche, rein In-House nutzbare App nicht über den Vertriebskanal *App Store* publiziert werden kann/darf. Mit neuen, öffentlich nutzbaren Features (siehe oben) wäre dieser Kritikpunkt entkräftet.

## Stundenpläne

Die Stundenpläne der Klassen oder gar für die einzelnen Lernenden könnten aus verschiedenen Schnittstellen abgerufen und in der App dargestellt werden. Gerade für Klassen/Berufe mit unregelmässigen Stundenplänen (Blockunterricht; häufig wechselnde Zimmer/Labors; ...) wäre diese einfache Verfügbarkeit der Stundenpläne hilfreich. Mögliche Quellen für die Rohdaten wären WebUntis oder EDUZug.

## Marktplatz

Ein interner Marktplatz für Lernende (und Mitarbeitende?) des GIBZ könnte eingerichtet werden: *Verkaufe Laptop*, *Suche Nachhilfe*, *Biete Mitfahrgelegenheit*, *Suche Trainingspartner/-in*, ...

## Unterricht

Für Informatik-Lernende ist die Arbeit mit *realen Projekten* im Unterricht deutlich interessanter und attraktiver als rein *schulische Übungen*. Peter Gisler plant, diese App nach der initialen Publikation fortlaufend weiterzuentwickeln - im regulären Unterricht und/oder mit speziell interessierten Lernenden im Rahmen eines Freikurses.

""";

class DemoPage extends StatelessWidget {
  final String title;

  const DemoPage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Informationen',
      child: Markdown(
        selectable: true,
        data: staticInfo,
        onTapLink: (text, url, title) {
          if (url != null && url.isNotEmpty) launch(url);
        },
        styleSheet: MarkdownStyleSheet(
          p: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontFamily: 'Abel',
          ),
          a: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
          ),
          h1: const TextStyle(
            fontFamily: 'Abel',
            color: Colors.white70,
            fontSize: 28,
          ),
          h2: const TextStyle(
              fontFamily: 'Abel',
              color: Colors.white70,
              fontWeight: FontWeight.bold),
          listIndent: 12,
          listBullet: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
