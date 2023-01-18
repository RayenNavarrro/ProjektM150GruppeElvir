import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';
import 'package:gibz_mobileapp/pages/demo_page.dart';
import 'package:gibz_mobileapp/pages/knowledge_base_detail.dart';
import 'package:gibz_mobileapp/pages/menu_info.dart';
import 'package:gibz_mobileapp/pages/rally/pending_stage_arrival_page.dart';
import 'package:gibz_mobileapp/pages/rally/points_display_page.dart';
import 'package:gibz_mobileapp/pages/rally/rally_end_page.dart';
import 'package:gibz_mobileapp/pages/rally/rally_entry_page.dart';
import 'package:gibz_mobileapp/pages/rally/stage_activity_page.dart';

import '../pages/rally/participating_party_form.dart';
import '../pages/rally/rally_permissions_page.dart';
import '../pages/rally/stage_page.dart';

abstract class PageConfiguration extends Equatable {
  final String path;
  final PageConfiguration? pageBefore;

  const PageConfiguration({required this.path, this.pageBefore});

  Page get page;

  String get firstPathSegment {
    Uri uri = Uri.parse(path);

    if (uri.pathSegments.isEmpty) {
      return "/";
    }

    return uri.pathSegments.first;
  }

  @override
  List<Object> get props => [path];

  Page getDefaultPage(Widget child) {
    return MaterialPage(
      child: child,
      key: ValueKey(path),
    );
  }
}

class DefaultPageConfiguration extends PageConfiguration {
  const DefaultPageConfiguration({required String path}) : super(path: path);

  @override
  Page get page => throw UnimplementedError();
}

// TODO: remove!
class DummyPageConfiguration extends PageConfiguration {
  final String title;

  const DummyPageConfiguration({
    required String path,
    required this.title,
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(DemoPage(title: title));
}

class ParkingInfoPageConfiguration extends PageConfiguration {
  const ParkingInfoPageConfiguration({
    String path = '/parking',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(const DemoPage(title: "Remove me!"));
}

class MenuInfoPageConfiguration extends PageConfiguration {
  const MenuInfoPageConfiguration({
    String path = '/menu',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(const MenuInfoPage());
}

class KnowledgeBasePageConfiguration extends PageConfiguration {
  const KnowledgeBasePageConfiguration({
    String path = '/knowledgebase',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page =>
      super.getDefaultPage(const DemoPage(title: "Handbuch Lernende"));
}

class KnowledgeBaseDetailPageConfiguration
    extends KnowledgeBasePageConfiguration {
  // final KnowledgeBaseEntry entry;
  final String id;
  final String title;
  const KnowledgeBaseDetailPageConfiguration({
    required this.id,
    required this.title,
    String path = '/knowledgebase/detail',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page =>
      super.getDefaultPage(KnowledgeBaseDetail(id: id, title: title));

  @override
  List<Object> get props => [path, id];
}

class RallyPermissionsPageConfiguration extends PageConfiguration {
  const RallyPermissionsPageConfiguration({
    String path = '/rally/permissions',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(const RallyPermissionsPage());
}

class RallyHomePageConfiguration extends PageConfiguration {
  const RallyHomePageConfiguration({
    String path = '/rally/home',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(const RallyEntryPage());
}

class ParticipatingPartyFormPageConfiguration extends PageConfiguration {
  final Rally rally;
  final ParticipatingParty participatingParty;

  const ParticipatingPartyFormPageConfiguration({
    required this.rally,
    required this.participatingParty,
    String path = '/rally/participatingParty',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(ParticipatingPartyForm(
        rallyTitle: rally.title,
        participatingPartyId: participatingParty.id,
      ));
}

class PendingStageArrivalPageConfiguration extends PageConfiguration {
  final Stage _stage;
  const PendingStageArrivalPageConfiguration(
    this._stage, {
    String path = '/rally/stage/pendingArrival',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(PendingStageArrivalPage(_stage));
}

class StagePageConfiguration extends PageConfiguration {
  final Stage _stage;

  const StagePageConfiguration(
    this._stage, {
    String path = '/rally/stage/',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(StagePage(_stage));
}

class StageActivityPageConfiguration extends PageConfiguration {
  final Stage _stage;

  const StageActivityPageConfiguration(
    this._stage, {
    String path = '/rally/stage/activity',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(StageActivityPage(_stage));
}

class PointsDisplayPageConfiguration extends PageConfiguration {
  final int latestPoints;
  final int totalPoints;

  const PointsDisplayPageConfiguration({
    required this.latestPoints,
    required this.totalPoints,
    String path = '/rally/stage/points',
    PageConfiguration? pageBefore,
  }) : super(path: path, pageBefore: pageBefore);

  @override
  Page get page => super.getDefaultPage(
        PointsDisplayPage(
          latestPoints: latestPoints,
          totalPoints: totalPoints,
        ),
      );
}

class RallyEndPageConfiguration extends PageConfiguration {
  const RallyEndPageConfiguration({String path = '/rally/end'})
      : super(path: path);

  @override
  Page get page => super.getDefaultPage(const RallyEndPage());
}

// class KnowledgeBaseVideoAttachmentPageConfiguration
//     extends KnowledgeBaseDetailPageConfiguration {
//   final int videoIndex;
//   const KnowledgeBaseVideoAttachmentPageConfiguration({
//     required KnowledgeBaseEntry entry,
//     required this.videoIndex,
//   }) : super(entry: entry, path: '/knowledgebase/detail/video');

//   @override
//   Page get page => super.getDefaultPage(
//         GibzVideoPlayer(
//             title: entry.videoAttachments[videoIndex].title,
//             videoUrl: entry.videoAttachments[videoIndex].url),
//       );

//   @override
//   List<Object> get props => [path, entry, videoIndex];
// }
