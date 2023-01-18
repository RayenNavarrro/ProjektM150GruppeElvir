import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

class UriRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');

    if (uri.pathSegments.isEmpty) {
      return const DummyPageConfiguration(path: '/', title: 'HOME');
    } else {
      final page = uri.pathSegments[0];
      switch (page) {
        case 'menu':
          return const MenuInfoPageConfiguration();
        case 'parking':
          return const ParkingInfoPageConfiguration();
        case 'knowledgebase':
          PageConfiguration knowledgeBase =
              const KnowledgeBasePageConfiguration();
          if (uri.pathSegments.length == 1) {
            return knowledgeBase;
          } else if (uri.pathSegments[1] == 'detail') {
            return KnowledgeBaseDetailPageConfiguration(
              id: uri.pathSegments[2],
              title: uri.queryParameters['title'] ?? '',
              path: uri.toString(),
              pageBefore: knowledgeBase,
            );
          }
          break;
        // TODO: Rally...!
      }
    }

    return const DummyPageConfiguration(path: '', title: 'NOT FOUND');
  }
}
