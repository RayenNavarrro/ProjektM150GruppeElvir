import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_state.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/utilities/default_markdown_stylesheet.dart';
import 'package:gibz_mobileapp/widgets/loading_indicator_button.dart';
import 'package:url_launcher/url_launcher.dart';

class StageActivityPage extends StatefulWidget {
  final Stage _stage;

  const StageActivityPage(this._stage, {Key? key}) : super(key: key);

  @override
  State<StageActivityPage> createState() => _StageActivityPageState();
}

class _StageActivityPageState extends State<StageActivityPage> {
  List<String?> answers = [];

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: widget._stage.information.title,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget._stage.stageActivity.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                MarkdownBody(
                  data: widget._stage.stageActivity.task,
                  styleSheet: defaultMarkdownStylesheet,
                  onTapLink: (text, url, title) {
                    if (url != null && url.isNotEmpty) launch(url);
                  },
                ),
              ],
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 20)),
        if (widget._stage.stageActivity is SingleChoiceActivity)
          SingleChoiceAnswerInput(
            activity: widget._stage.stageActivity as SingleChoiceActivity,
          ),
        if (widget._stage.stageActivity is MultipleChoiceActivity)
          MultipleChoiceAnswerInput(
            activity: widget._stage.stageActivity as MultipleChoiceActivity,
          ),
        if (widget._stage.stageActivity is TextInputActivity)
          TextInputAnswerInput(
            activity: widget._stage.stageActivity as TextInputActivity,
          ),
        SliverToBoxAdapter(
          child: BlocConsumer<RallyBloc, RallyState>(
            listener: (context, state) {
              if (state is PendingChallenge && state.answers != null) {
                setState(() => answers = state.answers!);
              }
            },
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
              child: ElevatedLoadingIndicatorButton(
                child: const Text('Absenden'),
                loadingAspect: LoadingAspect.submitStageActivityAnswer,
                onPressed: () {
                  context.read<RallyBloc>().add(AnswerSubmissionRequestedEvent(
                        widget._stage.stageActivity.id,
                        answers,
                      ));
                },
                onPressedCondition: () =>
                    answers.isNotEmpty &&
                    answers.every((element) => element?.isNotEmpty ?? false),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SingleChoiceAnswerInput extends StatefulWidget {
  final SingleChoiceActivity activity;

  const SingleChoiceAnswerInput({required this.activity, Key? key})
      : super(key: key);

  @override
  State<SingleChoiceAnswerInput> createState() =>
      _SingleChoiceAnswerInputState();
}

class _SingleChoiceAnswerInputState extends State<SingleChoiceAnswerInput> {
  String? _answer;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ((context, index) => RadioListTile<String>(
              title: Text(
                widget.activity.answers[index].answerText,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: widget.activity.answers[index].id,
              groupValue: _answer,
              onChanged: (String? value) {
                if (value != null) {
                  context
                      .read<RallyBloc>()
                      .add(ActivityAnswerUpdatedEvent([value]));
                  setState(() {
                    _answer = value;
                  });
                }
              },
            )),
        childCount: widget.activity.answers.length,
      ),
    );
  }
}

class MultipleChoiceAnswerInput extends StatefulWidget {
  final MultipleChoiceActivity activity;
  const MultipleChoiceAnswerInput({required this.activity, Key? key})
      : super(key: key);

  @override
  State<MultipleChoiceAnswerInput> createState() =>
      _MultipleChoiceAnswerInputState();
}

class _MultipleChoiceAnswerInputState extends State<MultipleChoiceAnswerInput> {
  final List<String> _answers = [];

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      ((context, index) => CheckboxListTile(
            title: Text(widget.activity.answers[index].answerText),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              final answerId = widget.activity.answers[index].id;
              setState(() {
                if (_answers.contains(answerId)) {
                  _answers.remove(answerId);
                } else {
                  _answers.add(answerId);
                }
              });
              context
                  .read<RallyBloc>()
                  .add(ActivityAnswerUpdatedEvent(_answers));
            },
            value: _answers.contains(widget.activity.answers[index].id),
          )),
      childCount: widget.activity.answers.length,
    ));
  }
}

class TextInputAnswerInput extends StatefulWidget {
  final TextInputActivity activity;
  const TextInputAnswerInput({required this.activity, Key? key})
      : super(key: key);

  @override
  State<TextInputAnswerInput> createState() => _TextInputAnswerInputState();
}

class _TextInputAnswerInputState extends State<TextInputAnswerInput> {
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _answerController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: _answerController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<RallyBloc>().add(ActivityAnswerUpdatedEvent([value]));
          },
        ),
      ),
    );
  }
}
