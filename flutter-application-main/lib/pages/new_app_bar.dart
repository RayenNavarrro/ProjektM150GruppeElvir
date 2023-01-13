import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/tab_bar_navigation_cubit.dart';
import 'package:gibz_mobileapp/widgets/background_wave_clipper.dart';

class PageWrapper extends StatelessWidget {
  final String pageTitle;
  final Widget child;

  const PageWrapper({required this.pageTitle, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: GibzAppBar(title: pageTitle),
          pinned: true,
        ),
        child
      ],
    ));
  }
}

class NewAppBarPage extends StatelessWidget {
  final Widget child;

  const NewAppBarPage({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: GibzAppBar(title: "XXX TITEL XXX"),
            // Set this param so that it won't go off the screen when scrolling
            pinned: true,
          ),
          child,
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Container(
          //         margin: const EdgeInsets.all(8),
          //         padding: const EdgeInsets.all(16),
          //         child: const Text(
          //             'GIBZ App ist eine neuartige und sehr moderne Smartphone App'),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // )
        ],
      ),
    );
  }
}

class GibzAppBar extends SliverPersistentHeaderDelegate {
  final String title;
  final List<Widget>? additionalChildren;

  GibzAppBar({required this.title, this.additionalChildren});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // var adjustedShinkOffset =
    //     shrinkOffset > minExtent ? minExtent : shrinkOffset;
    // double offset = (minExtent - adjustedShinkOffset) * 0.5;
    // double topPadding = MediaQuery.of(context).padding.top + 45;

    return Stack(
      children: [
        const BackgroundWave(),
        Positioned(
          // top: topPadding + offset,
          bottom: 0,
          top: 50,
          left: 16,
          right: 16,
          child: SizedBox(
            height: 180,
            child: Stack(
              children: [
                Positioned(
                  top: 2,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      context.read<TabBarNavigationCubit>().showMainMenu();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // if (true)
                if (Navigator.of(context).canPop())
                  Positioned(
                    top: 45,
                    left: 0,
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.white),
                          //   borderRadius: const BorderRadius.all(
                          //     Radius.circular(4),
                          //   ),
                          // ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 4,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                Positioned(
                  top: 0,
                  left: 50,
                  right: 0,
                  child: PageTitle(title: title),
                ),
                // Positioned(
                //   top: 0,
                //   bottom: 10,
                //   left: 0,
                //   right: 0,
                //   child: Stack(
                //     children: [
                //       ,
                //       ,
                //     ],
                //   ),
                // ),
                if (additionalChildren != null) ...?additionalChildren
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class BackgroundWave extends StatelessWidget {
  const BackgroundWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ClipPath(
        clipper: BackgroundWaveClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 280,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(10, 10),
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.red,
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 98, 160),
                Color.fromARGB(255, 31, 138, 205)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: AutoSizeText(
        title,
        maxLines: 3,
        style: const TextStyle(
          fontFamily: "CorporateS",
          fontSize: 34,
          color: Colors.white,
        ),
      ),
    );
  }
}
