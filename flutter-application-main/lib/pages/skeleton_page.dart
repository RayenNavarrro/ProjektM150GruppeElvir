import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/pages/new_app_bar.dart';

class SkeletonPage extends StatelessWidget {
  final String pageTitle;
  final List<Widget> slivers;

  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const SkeletonPage({
    required this.pageTitle,
    this.slivers = const [],
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: GibzAppBar(title: pageTitle),
              pinned: true,
            ),
            ...slivers
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
