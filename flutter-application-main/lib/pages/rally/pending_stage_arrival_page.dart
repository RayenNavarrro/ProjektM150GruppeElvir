import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/utilities/default_markdown_stylesheet.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/rally/rally_models.dart';

class PendingStageArrivalPage extends StatelessWidget {
  final Stage stage;

  const PendingStageArrivalPage(this.stage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: stage.preArrivalInformation.title,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Opacity(
                      opacity: 0.15,
                      child: Lottie.asset(
                        'assets/animations/lottie/bluetooth_ranging.json',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarkdownBody(
                          data: stage.preArrivalInformation.content,
                          styleSheet: defaultMarkdownStylesheet,
                          onTapLink: (text, url, title) {
                            if (url != null && url.isNotEmpty) launch(url);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SafeArea(
                top: false,
                left: false,
                right: false,
                child: TextButton(
                  onPressed: () {
                    context.read<RallyBloc>().add(StageSkipRequestedEvent());
                  },
                  child: const Text('Station überspringen'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
