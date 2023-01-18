import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/pages/video_player.dart';
import 'package:gibz_mobileapp/utilities/default_markdown_stylesheet.dart';
import 'package:gibz_mobileapp/widgets/loading_indicator_button.dart';
import 'package:url_launcher/url_launcher.dart';

class StagePage extends StatelessWidget {
  final Stage stage;

  const StagePage(this.stage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: stage.information.title,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: MarkdownBody(
                    data: stage.information.content,
                    styleSheet: defaultMarkdownStylesheet,
                    onTapLink: (text, url, title) {
                      if (url != null && url.isNotEmpty) launch(url);
                    },
                  ),
                ),
                for (VideoAttachment video in stage.information.attachments
                    .whereType<VideoAttachment>()
                    .toList())
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GibzVideoPlayer(
                      title: video.title,
                      videoUrl: video.url,
                    ),
                  ),
                for (ExternalLinkAttachment link in stage
                    .information.attachments
                    .whereType<ExternalLinkAttachment>()
                    .toList())
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      link.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    leading: Icon(
                      Icons.open_in_new_outlined,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    onTap: () async {
                      await launch(link.url);
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, bottom: 35),
                  child: OutlinedLoadingIndicatorButton(
                      child: const Text('Zur Challenge'),
                      loadingAspect: LoadingAspect.none,
                      onPressed: () {
                        context
                            .read<RallyBloc>()
                            .add(ChallengeRequestedEvent(stage));
                      }),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
