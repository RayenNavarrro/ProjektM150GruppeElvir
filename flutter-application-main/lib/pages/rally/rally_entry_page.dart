import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_state.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/widgets/loading_indicator_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/rally/rally_bloc.dart';

class RallyEntryPage extends StatefulWidget {
  const RallyEntryPage({Key? key}) : super(key: key);

  @override
  State<RallyEntryPage> createState() => _RallyEntryPageState();
}

class _RallyEntryPageState extends State<RallyEntryPage> {
  final joiningCodeController = TextEditingController();

  @override
  void dispose() {
    joiningCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: "GIBZ Rallye",
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Gib den sechsstelligen Code ein, um die Rallye zu starten.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: BlocBuilder<RallyBloc, RallyState>(
                    builder: ((context, state) {
                      return TextFormField(
                        controller: joiningCodeController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          errorText: (state is NotStartedState)
                              ? state.errorMessage
                              : null,
                          counterText: "",
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 10,
                          height: 0.7,
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                      );
                    }),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                    valueListenable: joiningCodeController,
                    builder: (context, value, child) {
                      return OutlinedLoadingIndicatorButton(
                        loadingAspect: LoadingAspect.joiningRally,
                        onPressed: _joinRally,
                        onPressedCondition: () => value.text.isNotEmpty,
                        child: const Text('Rallye START'),
                      );
                    }),
                FutureBuilder(
                  future: _hasOngoingRally(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<RallyBloc>()
                                .add(ResumeRequestedEvent());
                          },
                          child: const Text('Letzte Rally fortsetzen'),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _joinRally() async {
    context
        .read<RallyBloc>()
        .add(RallyJoiningRequestedEvent(int.parse(joiningCodeController.text)));
  }

  Future<bool> _hasOngoingRally() async {
    final prefs = await SharedPreferences.getInstance();
    final rallyId = prefs.getString("rallyId");
    final participatingPartyId = prefs.getString("participatingPartyId");
    final stageId = prefs.getString("lastCompletedStageId");

    return (rallyId?.isNotEmpty ?? false) &&
        (participatingPartyId?.isNotEmpty ?? false) &&
        (stageId?.isNotEmpty ?? false);
  }
}
