import 'package:flutter/material.dart';

class GibzTabBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String pageTitleHeroTag;

  const GibzTabBar({
    required this.title,
    this.pageTitleHeroTag = 'page-wrapper-title',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'page-navigation-back-button',
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  child: const Icon(
                    Icons.navigate_before,
                    size: 30,
                    color: Color.fromARGB(255, 18, 50, 120),
                  ),
                  onTap: () {
                    // context.read<NavigationCubit>().pop();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: Hero(
                tag: pageTitleHeroTag,
                child: Text(
                  title,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    height: 1.1,
                    fontFamily: 'Saira Condensed',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(300);
}
