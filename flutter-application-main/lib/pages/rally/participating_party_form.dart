import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:gibz_mobileapp/widgets/loading_indicator_button.dart';

import '../../bloc/rally/rally_state.dart';

class ParticipatingPartyForm extends StatefulWidget {
  final String rallyTitle;
  final String participatingPartyId;

  const ParticipatingPartyForm({
    required this.rallyTitle,
    required this.participatingPartyId,
    Key? key,
  }) : super(key: key);

  @override
  State<ParticipatingPartyForm> createState() => _ParticipatingPartyFormState();
}

class _ParticipatingPartyFormState extends State<ParticipatingPartyForm> {
  late TextEditingController _titleController;

  static List<String> participatingPartyNames = [""];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RallyBloc, RallyState>(
      listener: ((context, state) {
        if (state is PendingParticipatingPartyCompletion &&
            state.indexOfMemberToDelete != null) {
          setState(() {
            participatingPartyNames.removeAt(state.indexOfMemberToDelete!);
          });
        }
      }),
      buildWhen: ((previous, current) =>
          current is PendingParticipatingPartyCompletion),
      builder: (context, state) => SkeletonPage(
        pageTitle: widget.rallyTitle,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Wähle einen Namen für dein Team:',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 40,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: _titleController,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Text(
                    'Gib die vollständigen Namen aller Teammitglieder ein:',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  ...participatingPartyNames
                      .asMap()
                      .map((index, name) => MapEntry(
                            index,
                            NameInput(index, participatingPartyNames[index]),
                          ))
                      .values
                      .toList(),
                  TextButton(
                    child: const Text('Teammitglied hinzufügen'),
                    onPressed: () {
                      participatingPartyNames.add("");
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      bottom: 30,
                    ),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _titleController,
                      builder: (context, title, child) {
                        return ElevatedLoadingIndicatorButton(
                          loadingAspect: LoadingAspect.startingRally,
                          child: const Text('Rallye starten'),
                          onPressed: _startRally,
                          onPressedCondition: () => title.text.isNotEmpty,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _startRally() {
    context.read<RallyBloc>().add(ParticipatingPartyDetailsCompleteRequestEvent(
          participatingPartyId: widget.participatingPartyId,
          title: _titleController.text,
          names: participatingPartyNames,
        ));
  }
}

class NameInput extends StatefulWidget {
  final int index;
  final String initialValue;
  const NameInput(this.index, this.initialValue, {Key? key}) : super(key: key);

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.initialValue;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        // decoration: const InputDecoration(
        //   border: OutlineInputBorder(),
        // ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              context
                  .read<RallyBloc>()
                  .add(TeamMemberDeletionRequestedEvent(widget.index));
            },
            icon: const Icon(
              Icons.delete,
              size: 20,
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15),
        ),
        controller: _nameController,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          _ParticipatingPartyFormState.participatingPartyNames[widget.index] =
              value;
        },
      ),
    );
  }
}
