import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/pages/new_app_bar.dart';

class PageWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final String pageTitleHeroTag;

  const PageWrapper({
    required this.title,
    required this.child,
    this.pageTitleHeroTag = 'page-wrapper-title',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewAppBarPage(child: child);
  }
}
